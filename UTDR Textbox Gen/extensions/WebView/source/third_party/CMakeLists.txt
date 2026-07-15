cmake_minimum_required(VERSION 3.18)

# -----------------------------------------------------------------------------
# Core "bag of usage requirements" your main target links to
# -----------------------------------------------------------------------------
add_library(ext_third_party INTERFACE)

# Common compile defs (adjust or remove)
target_compile_definitions(ext_third_party INTERFACE HAVE_THIRDPARTY_FEATURE=1)

# List of runtime files to bubble up to parent
set(_EXT_TP_RUNTIME_DLLS "")

# =============================================================================
# WINDOWS
# =============================================================================
if(WIN32)
  include(FetchContent)
  FetchContent_Declare(
      webview
      GIT_REPOSITORY https://github.com/webview/webview
      GIT_TAG        0.12.0           # pin a version
  )
  FetchContent_MakeAvailable(webview)

  target_link_libraries(ext_third_party INTERFACE webview::core)
# =============================================================================
# APPLE (macOS, iOS, tvOS)
# =============================================================================
elseif(APPLE)
	# =============================================================================
	# iOS
	# =============================================================================
	if(CMAKE_SYSTEM_NAME STREQUAL "iOS")
    target_link_libraries(ext_third_party INTERFACE
      "-framework Foundation"
      "-framework UIKit"
      "-framework WebKit"
    )
  # =============================================================================
  # tvOS
  # =============================================================================
  elseif(CMAKE_SYSTEM_NAME STREQUAL "tvOS")
	# =============================================================================
	# macOS
	# =============================================================================
  else()
    target_link_libraries(ext_third_party INTERFACE
      "-framework Foundation"
      "-framework AppKit"
      "-framework WebKit"
    )
  endif()
# =============================================================================
# ANDROID
# =============================================================================
elseif(ANDROID)
# =============================================================================
# LINUX
# =============================================================================
elseif(UNIX)

  include(FetchContent)
  FetchContent_Declare(
      webview
      GIT_REPOSITORY https://github.com/webview/webview
      GIT_TAG        0.12.0           # pin a version
  )
  FetchContent_MakeAvailable(webview)

  target_link_libraries(ext_third_party INTERFACE webview::core)

  # ---------------------------------------------------------------------------
  # Steam Runtime (Scout) sysroot support (Linux only)
  # ---------------------------------------------------------------------------
  # Allow the build system to point at the Steam Runtime sysroot.
  # Example sysroot root should contain usr/include, usr/lib, usr/share, etc.
  set(STEAMRT_SYSROOT "" CACHE PATH "Path to Steam Runtime sysroot root (scout)")

  if(STEAMRT_SYSROOT)
    message(STATUS "Using Steam Runtime sysroot: ${STEAMRT_SYSROOT}")

    # Tell the compiler & linker to use the sysroot
    target_compile_options(ext_third_party INTERFACE
      "--sysroot=${STEAMRT_SYSROOT}"
    )
    target_link_options(ext_third_party INTERFACE
      "--sysroot=${STEAMRT_SYSROOT}"
    )

    # Make CMake's find_* prefer the sysroot (helps some finders)
    set(CMAKE_SYSROOT "${STEAMRT_SYSROOT}")
    list(PREPEND CMAKE_FIND_ROOT_PATH "${STEAMRT_SYSROOT}")

    # Make pkg-config look inside the sysroot for .pc files
    # (This is critical for GTK/WebKit to resolve within the runtime.)
    set(ENV{PKG_CONFIG_SYSROOT_DIR} "${STEAMRT_SYSROOT}")

    # Most distros: pc files live in these two
    set(_pc_libdir
      "${STEAMRT_SYSROOT}/usr/lib/pkgconfig"
      "${STEAMRT_SYSROOT}/usr/lib/x86_64-linux-gnu/pkgconfig"
      "${STEAMRT_SYSROOT}/usr/share/pkgconfig"
    )

    # Join with ':' for PKG_CONFIG_LIBDIR
    string(JOIN ":" _pc_libdir_joined ${_pc_libdir})
    set(ENV{PKG_CONFIG_LIBDIR} "${_pc_libdir_joined}")

    # Optional but often helpful so pkg-config doesn't pick host includes/libs
    set(ENV{PKG_CONFIG_PATH} "")
  else()
    message(STATUS "STEAMRT_SYSROOT not set; using host system libs")
  endif()


  # ---- GTK via pkg-config ----
  find_package(PkgConfig REQUIRED)

endif()

# =============================================================================
# Bubble up runtime list to parent
# =============================================================================
set(EXT_TP_RUNTIME_DLLS
    "${_EXT_TP_RUNTIME_DLLS}"
    PARENT_SCOPE)

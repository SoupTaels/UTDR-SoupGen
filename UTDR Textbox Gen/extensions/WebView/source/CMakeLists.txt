cmake_minimum_required(VERSION 3.18)
project(GMWebView LANGUAGES CXX)

# ============================================================
# Global language / options
# ============================================================
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

option(EXT_STRICT_WARNINGS "Enable -Wall/-Wextra or /W4" ON)
option(EXT_USE_THIRD_PARTY "Enable third_party directory" ON)

# Apple "native flavour" (ObjC wrapper + shared C++ native core)
option(EXT_APPLE_NATIVE_FRAMEWORK
       "Use Apple NATIVE flavour (ObjC wrapper + shared C++ native core)"
       OFF)

option(EXTGEN_ENABLE_SWIFT "Enable Swift sources (Apple only)" ON)

# Packaging config used by xcframework packagers
set(EXT_APPLE_PACKAGE_CONFIG "Release" CACHE STRING "Config used by xcframework packagers (Debug/Release)")
set_property(CACHE EXT_APPLE_PACKAGE_CONFIG PROPERTY STRINGS Debug Release)

# GameMaker XCode integration (iOS|tvOS development, optional)
set(EXT_GM_XCODEPROJ "" CACHE STRING "Absolute path to GameMaker-exported .xcodeproj")
set(EXT_GM_APP_TARGET "" CACHE STRING "Optional: GameMaker app target name (empty = auto-detect)")

set(EXT_GM_XCODEPROJ_OVERRIDE "" CACHE STRING "Override GM .xcodeproj (src-controlled)")
set(EXT_GM_APP_TARGET_OVERRIDE "" CACHE STRING "Override GM app target (src-controlled)")

# Disable code signing for Xcode-generated projects (device & sim)
if(APPLE AND CMAKE_GENERATOR STREQUAL "Xcode")
  set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGNING_ALLOWED "NO")
  set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGNING_REQUIRED "NO")
  set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGNING_STYLE "Manual")
  set(CMAKE_XCODE_ATTRIBUTE_DEVELOPMENT_TEAM "")
  set(CMAKE_XCODE_ATTRIBUTE_PROVISIONING_PROFILE_SPECIFIER "")
endif()

# User-supplied Nintendo Switch MSBuild props (we DO NOT SHIP Nintendo's props)
set(EXT_SWITCH_USER_PROPS "" CACHE FILEPATH
    "Path to a user-provided Nintendo Switch .props file to import into generated VS projects")

option(EXTGEN_PLATFORM_SWITCH "Enable Switch-specific VS integration" OFF)

set(EXT_OUTPUT_DIR "../" CACHE STRING "Where to copy the final built binary")
set(EXT_APPLE_DROP_DIR "" CACHE STRING "Where to copy packaged Apple xcframework zip (optional)")
set(EXT_ANDROID_OUTPUT_DIR "" CACHE STRING "Where to copy the JNI binaries (optional)")

# ============================================================
# Platform classification
# ============================================================
set(EXTGEN_IS_IOS FALSE)
set(EXTGEN_IS_TVOS FALSE)
set(EXTGEN_IS_APPLE_MOBILE FALSE)
set(EXTGEN_IS_PS4 FALSE)
set(EXTGEN_IS_PS5 FALSE)

if(APPLE)
  # CMAKE_OSX_SYSROOT may be: iphoneos, iphonesimulator, appletvos, appletvsimulator, or a full path.
  if(CMAKE_OSX_SYSROOT MATCHES "iphone")
    set(EXTGEN_IS_IOS TRUE)
    set(EXTGEN_IS_APPLE_MOBILE TRUE)
  elseif(CMAKE_OSX_SYSROOT MATCHES "appletv")
    set(EXTGEN_IS_TVOS TRUE)
    set(EXTGEN_IS_APPLE_MOBILE TRUE)
  endif()
endif()

if(CMAKE_SYSTEM_NAME STREQUAL "ORBIS")
  set(EXTGEN_IS_PS4 TRUE)
elseif(CMAKE_SYSTEM_NAME STREQUAL "Prospero")
  set(EXTGEN_IS_PS5 TRUE)
endif()

# ============================================================
# Target kind
# ============================================================
if(EXTGEN_IS_APPLE_MOBILE)
  add_library(${PROJECT_NAME} STATIC)
else()
  add_library(${PROJECT_NAME} SHARED)
endif()

set_target_properties(${PROJECT_NAME} PROPERTIES
  POSITION_INDEPENDENT_CODE ON
  OUTPUT_NAME "${PROJECT_NAME}"
)

# ============================================================
# Includes & source discovery (code_gen)
# ============================================================
file(GLOB SRC_CORE CONFIGURE_DEPENDS
  ${CMAKE_CURRENT_SOURCE_DIR}/code_gen/core/*.cpp
  ${CMAKE_CURRENT_SOURCE_DIR}/code_gen/core/*.mm
  ${CMAKE_CURRENT_SOURCE_DIR}/code_gen/core/*.swift
)
target_sources(${PROJECT_NAME} PRIVATE ${SRC_CORE})

target_include_directories(
  ${PROJECT_NAME} PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/code_gen
    ${CMAKE_CURRENT_SOURCE_DIR}/code_gen/core
)

file(GLOB SRC_COMMON CONFIGURE_DEPENDS
  ${CMAKE_CURRENT_SOURCE_DIR}/code_gen/*.cpp
)
target_sources(${PROJECT_NAME} PRIVATE ${SRC_COMMON})

# Platform folders inside code_gen
file(GLOB_RECURSE SRC_ANDROID CONFIGURE_DEPENDS
  ${CMAKE_CURRENT_SOURCE_DIR}/code_gen/android/*.[cS]
  ${CMAKE_CURRENT_SOURCE_DIR}/code_gen/android/*.cpp
  ${CMAKE_CURRENT_SOURCE_DIR}/code_gen/native/*.[cS]
  ${CMAKE_CURRENT_SOURCE_DIR}/code_gen/native/*.cpp
)

file(GLOB_RECURSE SRC_NATIVE CONFIGURE_DEPENDS
  ${CMAKE_CURRENT_SOURCE_DIR}/code_gen/native/*.[cS]
  ${CMAKE_CURRENT_SOURCE_DIR}/code_gen/native/*.cpp
)

file(GLOB_RECURSE SRC_IOS CONFIGURE_DEPENDS
  ${CMAKE_CURRENT_SOURCE_DIR}/code_gen/ios/*.[cS]
  ${CMAKE_CURRENT_SOURCE_DIR}/code_gen/ios/*.cpp
  ${CMAKE_CURRENT_SOURCE_DIR}/code_gen/ios/*.mm
  ${CMAKE_CURRENT_SOURCE_DIR}/code_gen/ios/*.swift
)

file(GLOB_RECURSE SRC_TVOS CONFIGURE_DEPENDS
  ${CMAKE_CURRENT_SOURCE_DIR}/code_gen/tvos/*.[cS]
  ${CMAKE_CURRENT_SOURCE_DIR}/code_gen/tvos/*.cpp
  ${CMAKE_CURRENT_SOURCE_DIR}/code_gen/tvos/*.mm
  ${CMAKE_CURRENT_SOURCE_DIR}/code_gen/tvos/*.swift
)

# "Native flavour" uses native + ios/tvos roots
set(SRC_IOS_NATIVE  ${SRC_NATIVE} ${SRC_IOS})
set(SRC_TVOS_NATIVE ${SRC_NATIVE} ${SRC_TVOS})

# User sources
add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/src")

# ============================================================
# Inject user properties into VS
# ============================================================
if(MSVC AND EXTGEN_PLATFORM_SWITCH)
  if(NOT EXT_SWITCH_USER_PROPS)
    message(FATAL_ERROR "EXTGEN_PLATFORM_SWITCH=ON but EXT_SWITCH_USER_PROPS is empty. Set it to your Nintendo .props.")
  endif()
  if(NOT EXISTS "${EXT_SWITCH_USER_PROPS}")
    message(FATAL_ERROR "EXT_SWITCH_USER_PROPS not found: ${EXT_SWITCH_USER_PROPS}")
  endif()
  
  set_property(TARGET ${PROJECT_NAME} APPEND PROPERTY VS_USER_PROPS "${EXT_SWITCH_USER_PROPS}")
endif()

# ============================================================
# Platform selection & defines
# ============================================================
if(ANDROID)
  message(STATUS "Including Android sources")
  target_sources(${PROJECT_NAME} PRIVATE ${SRC_ANDROID})
  target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/code_gen/android)
  target_compile_definitions(${PROJECT_NAME} PRIVATE OS_ANDROID EXTGEN_HAS_JNI=1)
  find_library(_log_lib log)
  find_library(_android_lib android)
  target_link_libraries(${PROJECT_NAME} PRIVATE ${_log_lib} ${_android_lib})
  message(STATUS "Android ABI=${CMAKE_ANDROID_ARCH_ABI}, STL=c++_static")

elseif(WIN32)
  message(STATUS "Including Windows sources")
  target_sources(${PROJECT_NAME} PRIVATE ${SRC_NATIVE})
  target_compile_definitions(${PROJECT_NAME} PRIVATE OS_WINDOWS EXTGEN_HAS_JNI=0)

elseif(EXTGEN_IS_IOS)
  message(STATUS "Including iOS sources")
  enable_language(OBJCXX)
  if(EXTGEN_ENABLE_SWIFT)
    enable_language(Swift)
    set_target_properties(${PROJECT_NAME} PROPERTIES
      XCODE_ATTRIBUTE_DEFINES_MODULE YES
      XCODE_ATTRIBUTE_SWIFT_INSTALL_OBJC_HEADER YES
      XCODE_ATTRIBUTE_SWIFT_OBJC_INTERFACE_HEADER_NAME "${PROJECT_NAME}-Swift.h"
      XCODE_ATTRIBUTE_SWIFT_OBJC_INTEROP_MODE objcxx
      XCODE_ATTRIBUTE_SWIFT_OBJC_BRIDGING_HEADER "${CMAKE_CURRENT_SOURCE_DIR}/code_gen/ios/${PROJECT_NAME}-Bridging-Header.h"
    )
  endif()

  if(EXT_APPLE_NATIVE_FRAMEWORK)
    message(STATUS "iOS flavour: NATIVE (ObjC wrapper + C++ native core)")
    target_sources(${PROJECT_NAME} PRIVATE ${SRC_IOS_NATIVE})
    target_compile_definitions(${PROJECT_NAME} PRIVATE EXTGEN_APPLE_NATIVE_FW=1)
  else()
    message(STATUS "iOS flavour: STANDARD (platform-native implementation)")
    target_sources(${PROJECT_NAME} PRIVATE ${SRC_IOS})
    target_compile_definitions(${PROJECT_NAME} PRIVATE EXTGEN_APPLE_NATIVE_FW=0)
  endif()

  target_compile_definitions(${PROJECT_NAME} PRIVATE OS_IOS EXTGEN_HAS_JNI=0)

elseif(EXTGEN_IS_TVOS)
  message(STATUS "Including tvOS sources")
  enable_language(OBJCXX)
  if(EXTGEN_ENABLE_SWIFT)
    enable_language(Swift)
    set_target_properties(${PROJECT_NAME} PROPERTIES
      XCODE_ATTRIBUTE_DEFINES_MODULE YES
      XCODE_ATTRIBUTE_SWIFT_INSTALL_OBJC_HEADER YES
      XCODE_ATTRIBUTE_SWIFT_OBJC_INTERFACE_HEADER_NAME "${PROJECT_NAME}-Swift.h"
      XCODE_ATTRIBUTE_SWIFT_OBJC_INTEROP_MODE objcxx
      XCODE_ATTRIBUTE_SWIFT_OBJC_BRIDGING_HEADER "${CMAKE_CURRENT_SOURCE_DIR}/code_gen/tvos/${PROJECT_NAME}-Bridging-Header.h"
    )
  endif()

  if(EXT_APPLE_NATIVE_FRAMEWORK)
    message(STATUS "tvOS flavour: NATIVE (ObjC wrapper + C++ native core)")
    target_sources(${PROJECT_NAME} PRIVATE ${SRC_TVOS_NATIVE})
    target_compile_definitions(${PROJECT_NAME} PRIVATE EXTGEN_APPLE_NATIVE_FW=1)
  else()
    message(STATUS "tvOS flavour: STANDARD (platform-native implementation)")
    target_sources(${PROJECT_NAME} PRIVATE ${SRC_TVOS})
    target_compile_definitions(${PROJECT_NAME} PRIVATE EXTGEN_APPLE_NATIVE_FW=0)
  endif()

  target_compile_definitions(${PROJECT_NAME} PRIVATE OS_TVOS EXTGEN_HAS_JNI=0)

elseif(APPLE)
  message(STATUS "Including macOS sources")
  enable_language(OBJCXX)
  target_sources(${PROJECT_NAME} PRIVATE ${SRC_NATIVE})
  target_compile_definitions(${PROJECT_NAME} PRIVATE OS_MACOS EXTGEN_HAS_JNI=0)

elseif(UNIX)
  message(STATUS "Including Linux sources")
  target_sources(${PROJECT_NAME} PRIVATE ${SRC_NATIVE})
  target_compile_definitions(${PROJECT_NAME} PRIVATE OS_LINUX EXTGEN_HAS_JNI=0)
endif()

# ============================================================
# Warnings
# ============================================================
if(EXT_STRICT_WARNINGS)
  if(MSVC)
    target_compile_options(${PROJECT_NAME} PRIVATE /W4 /permissive-)
    target_compile_definitions(${PROJECT_NAME} PRIVATE _CRT_SECURE_NO_WARNINGS WIN32_LEAN_AND_MEAN NOMINMAX)
  else()
    target_compile_options(${PROJECT_NAME} PRIVATE
      $<$<COMPILE_LANGUAGE:CXX>:-Wall -Wextra -Wpedantic>
      $<$<COMPILE_LANGUAGE:OBJCXX>:-Wall -Wextra -Wpedantic>
    )

    if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
      target_compile_options(${PROJECT_NAME} PRIVATE
        $<$<COMPILE_LANGUAGE:CXX>:-Wno-unknown-pragmas -Wno-gnu-zero-variadic-macro-arguments>
        $<$<COMPILE_LANGUAGE:OBJCXX>:-Wno-unknown-pragmas -Wno-gnu-zero-variadic-macro-arguments>
      )
    endif()
  endif()
endif()

# ============================================================
# third_party
# ============================================================
set(EXT_THIRDPARTY_DIR "${CMAKE_CURRENT_SOURCE_DIR}/third_party")
if(EXT_USE_THIRD_PARTY AND EXISTS "${EXT_THIRDPARTY_DIR}/CMakeLists.txt")
  message(STATUS "Loading third_party from: ${EXT_THIRDPARTY_DIR}")
  set(EXT_MAIN_TARGET "${PROJECT_NAME}")
  add_subdirectory("${EXT_THIRDPARTY_DIR}")

  if(TARGET ext_third_party)
    target_link_libraries(${PROJECT_NAME} PRIVATE ext_third_party)
  endif()
else()
  message(STATUS "No third_party directory (or disabled).")
endif()

# ============================================================
# RPATH for *nix (not iOS/tvOS)
# ============================================================
if(APPLE AND NOT EXTGEN_IS_APPLE_MOBILE)
  set_target_properties(
    ${PROJECT_NAME}
    PROPERTIES
      MACOSX_RPATH ON
      BUILD_WITH_INSTALL_RPATH ON
      INSTALL_RPATH "@loader_path"
  )
elseif(UNIX AND NOT ANDROID)
  set_target_properties(
    ${PROJECT_NAME}
    PROPERTIES
      BUILD_WITH_INSTALL_RPATH ON
      INSTALL_RPATH "$ORIGIN"
  )
endif()

# ============================================================
# Outputs / post-build copies
# ============================================================

# Normalize EXT_OUTPUT_DIR -> _EXT_OUT_DIR
if(EXT_OUTPUT_DIR STREQUAL "")
  set(_EXT_OUT_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../")
elseif(IS_ABSOLUTE "${EXT_OUTPUT_DIR}")
  set(_EXT_OUT_DIR "${EXT_OUTPUT_DIR}")
else()
  get_filename_component(_EXT_OUT_DIR
    "${CMAKE_CURRENT_SOURCE_DIR}/${EXT_OUTPUT_DIR}"
    ABSOLUTE
  )
endif()

if(ANDROID)

  if(EXT_ANDROID_OUTPUT_DIR STREQUAL "")
    set(_EXT_ANDROID_OUT_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../AndroidSource")
  elseif(IS_ABSOLUTE "${EXT_ANDROID_OUTPUT_DIR}")
    set(_EXT_ANDROID_OUT_DIR "${EXT_ANDROID_OUTPUT_DIR}")
  else()
    get_filename_component(_EXT_ANDROID_OUT_DIR
    "${CMAKE_CURRENT_SOURCE_DIR}/${EXT_ANDROID_OUTPUT_DIR}"
    ABSOLUTE
    )
  endif()

  set(_ANDROID_OUT_BASE "${_EXT_ANDROID_OUT_DIR}/libs")
  set(_ANDROID_ABI_DIR "${_ANDROID_OUT_BASE}/${CMAKE_ANDROID_ARCH_ABI}")

  add_custom_command(
    TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E make_directory "${_ANDROID_ABI_DIR}"
    COMMAND ${CMAKE_COMMAND} -E copy_if_different "$<TARGET_FILE:${PROJECT_NAME}>"
            "${_ANDROID_ABI_DIR}/lib$<TARGET_PROPERTY:${PROJECT_NAME},OUTPUT_NAME>.so"
    COMMENT "Copying Android shared library to ${_ANDROID_ABI_DIR}"
  )

  if(DEFINED EXT_TP_ANDROID_AAR AND EXISTS "${EXT_TP_ANDROID_AAR}")
    set(_ANDROID_AAR_DIR "${_EXT_ANDROID_OUT_DIR}/libs-aar")
    add_custom_command(
      TARGET ${PROJECT_NAME} POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E make_directory "${_ANDROID_AAR_DIR}"
      COMMAND ${CMAKE_COMMAND} -E copy_if_different "${EXT_TP_ANDROID_AAR}" "${_ANDROID_AAR_DIR}/"
      COMMENT "Copying third-party AAR to ${_ANDROID_AAR_DIR}"
    )
  endif()

  if(EXT_TP_RUNTIME_DLLS)
    add_custom_command(
      TARGET ${PROJECT_NAME} POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E copy_if_different ${EXT_TP_RUNTIME_DLLS} "${_ANDROID_ABI_DIR}/"
      COMMENT "Copying third-party Android .so(s) to ${_ANDROID_ABI_DIR}"
    )
  endif()

elseif(EXTGEN_IS_APPLE_MOBILE)
  message(STATUS "Apple mobile build: use package_ios_xcframework / package_tvos_xcframework targets.")

else()
  add_custom_command(
    TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND "${CMAKE_COMMAND}" -E copy_if_different "$<TARGET_FILE:${PROJECT_NAME}>"
            "${_EXT_OUT_DIR}/$<TARGET_FILE_NAME:${PROJECT_NAME}>"
    COMMENT "Copying shared library to ${_EXT_OUT_DIR}"
  )

  if(WIN32 AND CMAKE_VERSION VERSION_GREATER_EQUAL 3.21)
    file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/_copy_runtime_dlls.cmake" [=[
      if(NOT DEFINED dlls OR dlls STREQUAL "")
        message(STATUS "No runtime DLLs to copy")
        return()
      endif()
      foreach(f IN LISTS dlls)
        if(EXISTS "${f}")
          file(COPY "${f}" DESTINATION "${dst}")
        endif()
      endforeach()
    ]=])

    add_custom_command(
      TARGET ${PROJECT_NAME} POST_BUILD
      COMMAND "${CMAKE_COMMAND}" -Ddlls="$<TARGET_RUNTIME_DLLS:${PROJECT_NAME}>"
              -Ddst="${_EXT_OUT_DIR}" -P "${CMAKE_CURRENT_BINARY_DIR}/_copy_runtime_dlls.cmake"
      COMMENT "Copying dependent runtime DLLs (if any)"
    )
  endif()

  if(DEFINED EXT_TP_RUNTIME_DLLS AND EXT_TP_RUNTIME_DLLS)
    add_custom_command(
      TARGET ${PROJECT_NAME} POST_BUILD
      COMMAND "${CMAKE_COMMAND}" -E copy_if_different ${EXT_TP_RUNTIME_DLLS} "${_EXT_OUT_DIR}/"
      COMMAND_EXPAND_LISTS
      COMMENT "Copying third-party runtime(s)"
    )
  endif()
endif()

# ============================================================
# Apple XCFramework packagers and Xcode auto-integration (iOS/tvOS)
# ============================================================
if(EXTGEN_IS_APPLE_MOBILE)
  include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/extgen_xcframework.cmake)

  # Effective values
  set(_EXT_GM_XCODEPROJ "${EXT_GM_XCODEPROJ}")
  if(NOT EXT_GM_XCODEPROJ_OVERRIDE STREQUAL "")
    set(_EXT_GM_XCODEPROJ "${EXT_GM_XCODEPROJ_OVERRIDE}")
  endif()
  
  set(_EXT_GM_APP_TARGET "${EXT_GM_APP_TARGET}")
  if(NOT EXT_GM_APP_TARGET_OVERRIDE STREQUAL "")
    set(_EXT_GM_APP_TARGET "${EXT_GM_APP_TARGET_OVERRIDE}")
  endif()

  add_custom_target(integrate_gamemaker
    COMMAND ${CMAKE_COMMAND}
      -DEXT_REPO_ROOT:PATH=${CMAKE_SOURCE_DIR}
      -DEXT_GM_XCODEPROJ:FILEPATH=${_EXT_GM_XCODEPROJ}
      -DEXT_GM_APP_TARGET:STRING=${_EXT_GM_APP_TARGET}
      -DEXT_EXT_XCODEPROJ:FILEPATH=${CMAKE_BINARY_DIR}/${PROJECT_NAME}.xcodeproj
      -DEXT_EXT_TARGET:STRING=${PROJECT_NAME}
      -P "${CMAKE_SOURCE_DIR}/cmake/extgen_integrate_gamemaker_xcode.cmake"
    COMMENT "Integrating extension into GameMaker Xcode project"
    VERBATIM
  )

  if(NOT EXT_ENABLE_GM_INTEGRATION)
    set_property(TARGET integrate_gamemaker PROPERTY EXCLUDE_FROM_ALL TRUE)
  endif()
endif()


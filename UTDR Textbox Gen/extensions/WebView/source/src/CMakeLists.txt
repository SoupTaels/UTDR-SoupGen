set(SRC_DIR ${CMAKE_CURRENT_LIST_DIR})

# =============================================================================
# Public headers for Apple XCFramework packaging
# Users should edit these to match their project structure.
# The packager will copy these into a headers folder passed to xcodebuild.
# =============================================================================
set(EXT_PUBLIC_HEADERS_IOS
    "${CMAKE_SOURCE_DIR}/src/ios/${PROJECT_NAME}_ios.h;${CMAKE_SOURCE_DIR}/code_gen/ios/${PROJECT_NAME}Internal_ios.h"
    CACHE STRING "Semicolon-separated list of public headers to embed in the iOS xcframework")

set(EXT_PUBLIC_HEADERS_TVOS
    "${CMAKE_SOURCE_DIR}/src/tvos/${PROJECT_NAME}_tvos.h;${CMAKE_SOURCE_DIR}/code_gen/tvos/${PROJECT_NAME}Internal_tvos.h"
    CACHE STRING "Semicolon-separated list of public headers to embed in the tvOS xcframework")

# =============================================================================
# WINDOWS
# =============================================================================
if(WIN32)
  file(GLOB GMWEBVIEW_SRCS CONFIGURE_DEPENDS
    "${SRC_DIR}/native/*.cpp"
    "${SRC_DIR}/GMWebViewManager/common/*.cpp"
    "${SRC_DIR}/GMWebViewManager/windows/*.cpp")
# =============================================================================
# APPLE (macOS, iOS, tvOS)
# =============================================================================
elseif(APPLE)
  if(CMAKE_OSX_SYSROOT MATCHES "iphone")
    file(GLOB GMWEBVIEW_SRCS CONFIGURE_DEPENDS
      "${SRC_DIR}/ios/*.mm"
      "${SRC_DIR}/GMWebViewManager/ios/*.mm"
    )
  elseif(MAKE_OSX_SYSROOT MATCHES "appletv")
    file(GLOB GMWEBVIEW_SRCS CONFIGURE_DEPENDS
      "${SRC_DIR}/tvos/*.mm"
      "${SRC_DIR}/GMWebViewManager/tvos/*.mm"
    )
  else() # macOS
    file(GLOB GMWEBVIEW_SRCS CONFIGURE_DEPENDS
      "${SRC_DIR}/native/*.cpp"
      "${SRC_DIR}/GMWebViewManager/macos/*.mm"
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
  file(GLOB GMWEBVIEW_SRCS CONFIGURE_DEPENDS
    "${SRC_DIR}/native/*.cpp"
    "${SRC_DIR}/GMWebViewManager/common/*.cpp"
    "${SRC_DIR}/GMWebViewManager/linux/*.cpp"
  )  
endif()

target_sources(${PROJECT_NAME} PRIVATE ${GMWEBVIEW_SRCS})
target_include_directories(${PROJECT_NAME} PRIVATE
  "${SRC_DIR}"
  "${SRC_DIR}/GMWebViewManager")
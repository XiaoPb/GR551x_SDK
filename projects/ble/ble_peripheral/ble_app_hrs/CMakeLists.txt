cmake_minimum_required(VERSION 3.20.0)

# message($ENV{SDK_BASE})
# include(G:/Code/GR551x_SDK/cmake/gcc-toolchain.cmake)
# find_package(Sdk REQUIRED HINTS $ENV{SDK_BASE})
find_package(Sdk REQUIRED HINTS PATHS G:/Code/GR551x_SDK/share/sdk-package)

project(ble_app_hrs)

set(CMAKE_BUILD_TYPE "Release")

application_sources(
    Src/platform/user_periph_setup.c
    Src/user/user_app.c
    Src/user/main.c
)

sdk_include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/platform
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/user
    # ${CMAKE_CURRENT_SOURCE_DIR}/Src/config
)

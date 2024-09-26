cmake_minimum_required(VERSION 3.20.0)

find_package(Sdk REQUIRED HINTS $ENV{SDK_BASE})

project(ble_app_template_dfu)

target_sources(app PRIVATE
    Src/platform/user_periph_setup.c
    Src/user/user_app.c
    Src/user/main.c
)

sdk_include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/platform
    ${CMAKE_CURRENT_SOURCE_DIR}/Src/user
)

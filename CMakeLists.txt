cmake_minimum_required(VERSION 3.20.0)
set(CMAKE_BUILD_TYPE "Release")

add_executable(${APPLICATION_NAME_ELF} misc/empty_file.c)

add_library(sdk_interface INTERFACE)

sdk_library_named(app)

sdk_library_named(sdk)
sdk_include_directories(
    include
    ${__build_dir}/include/generated
    ${SDK_BASE}/platform/arch/arm/cortex-m/cmsis/core/include
    ${SDK_BASE}/platform/boards
    ${SDK_BASE}/platform/include
    ${SDK_BASE}/platform/soc/include
    ${SDK_BASE}/platform/soc/linker/keil
)

sdk_library_sources(
    ${SDK_BASE}/platform/boards/board_SK.c
    ${SDK_BASE}/platform/soc/common/gr_interrupt.c
    ${SDK_BASE}/platform/soc/common/gr_platform.c
    ${SDK_BASE}/platform/soc/common/gr_system.c
    ${SDK_BASE}/platform/soc/src/gr_soc.c
    ${SDK_BASE}/components/sdk/ble.c

    ${SDK_BASE}/platform/arch/arm/cortex-m/gcc/startup_gr55xx.s
)

find_library(ble_sdk ble_sdk ${SDK_BASE}/platform/soc/linker/gcc/)

target_link_libraries(sdk PUBLIC -Wl,--start-group)

add_subdirectory(external)
add_subdirectory(drivers)
add_subdirectory(components)

target_link_libraries(sdk PUBLIC ${ble_sdk})
target_link_libraries(sdk PUBLIC -Wl,--end-group)

if(CONFIG_GR5515_SOC)
    file(READ ${SDK_BASE}/platform/soc/linker/gcc/gcc_linker_gr5515.lds FILE_LINKER)
endif(CONFIG_GR5515_SOC)

if(CONFIG_GR5513_SOC)
    file(READ ${SDK_BASE}/platform/soc/linker/gcc/gcc_linker_gr5515.lds FILE_LINKER)
endif(CONFIG_GR5513_SOC)

string(REPLACE "ORIGIN = 0x01002000" "ORIGIN = ${CONFIG_APP_CODE_LOAD_ADDR}" FILE_LINKER "${FILE_LINKER}")

file(WRITE ${PROJECT_BINARY_DIR}/linker/gcc_linker.lds "${FILE_LINKER}")


set(LINK_SCRIPT "")
list(APPEND LINK_SCRIPT ${PROJECT_BINARY_DIR}/linker/gcc_linker.lds)
list(APPEND LINK_SCRIPT ${SDK_BASE}/platform/soc/linker/gcc/rom_symbol_gcc.txt)



# add_compile_definitions(NDEBUG)
target_link_options(${APPLICATION_NAME_ELF} PUBLIC
    -T${LINK_SCRIPT}
    -mcpu=cortex-m4
    --specs=nosys.specs
    -Wl,--gc-sections
    -Wl,-Map=sdk/${APPLICATION_NAME}.map
    -Wl,--cref
    -Wl,--print-memory-usage

)

target_link_libraries(${APPLICATION_NAME_ELF} PUBLIC
    app
    sdk
    sdk_interface
    )

# set_target_properties(${APPLICATION_NAME_ELF} PROPERTIES LINK_FLAGS "-Wl,--start-group -Wl,--end-group")

include(cmake/gr5xxx-postbuild.cmake)

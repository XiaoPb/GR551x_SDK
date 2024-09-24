cmake_minimum_required(VERSION 3.20.0)
set(CMAKE_BUILD_TYPE "Release")
add_executable(${APPLICATION_NAME_ELF})

add_library(sdk_interface INTERFACE)

# sdk_library_named(app)

# sdk_library_named(sdk)
sdk_include_directories(
    include
    ${PROJECT_BINARY_DIR}/include/generated

    ${SDK_BASE}/components/boards
    ${SDK_BASE}/components/drivers_ext/gr55xx
    ${SDK_BASE}/components/drivers_ext/st7735
    ${SDK_BASE}/components/drivers_ext/vs1005
    ${SDK_BASE}/components/libraries/app_alarm
    ${SDK_BASE}/components/libraries/app_assert
    ${SDK_BASE}/components/libraries/app_error
    ${SDK_BASE}/components/libraries/app_key
    ${SDK_BASE}/components/libraries/app_log
    ${SDK_BASE}/components/libraries/app_queue
    ${SDK_BASE}/components/libraries/app_timer
    ${SDK_BASE}/components/libraries/at_cmd
    ${SDK_BASE}/components/libraries/gui
    ${SDK_BASE}/components/libraries/gui/gui_config
    ${SDK_BASE}/components/libraries/hal_flash
    ${SDK_BASE}/components/libraries/fault_trace
    ${SDK_BASE}/components/libraries/hci_uart
    ${SDK_BASE}/components/libraries/pmu_calibration
    ${SDK_BASE}/components/libraries/ring_buffer
    ${SDK_BASE}/components/libraries/sensorsim
    ${SDK_BASE}/components/libraries/utility
    ${SDK_BASE}/components/patch/ind
    ${SDK_BASE}/components/profiles/ams_c
    ${SDK_BASE}/components/profiles/ancs_c
    ${SDK_BASE}/components/profiles/ans
    ${SDK_BASE}/components/profiles/ans_c
    ${SDK_BASE}/components/profiles/bas
    ${SDK_BASE}/components/profiles/bas_c
    ${SDK_BASE}/components/profiles/bcs
    ${SDK_BASE}/components/profiles/bps
    ${SDK_BASE}/components/profiles/common
    ${SDK_BASE}/components/profiles/cscs
    ${SDK_BASE}/components/profiles/cts
    ${SDK_BASE}/components/profiles/cts_c
    ${SDK_BASE}/components/profiles/dis
    ${SDK_BASE}/components/profiles/dis_c
    ${SDK_BASE}/components/profiles/gls
    ${SDK_BASE}/components/profiles/gus
    ${SDK_BASE}/components/profiles/gus_c
    ${SDK_BASE}/components/profiles/hids
    ${SDK_BASE}/components/profiles/hrrcps
    ${SDK_BASE}/components/profiles/hrs
    ${SDK_BASE}/components/profiles/hrs_c
    ${SDK_BASE}/components/profiles/hts
    ${SDK_BASE}/components/profiles/ias
    ${SDK_BASE}/components/profiles/lls
    ${SDK_BASE}/components/profiles/lns
    ${SDK_BASE}/components/profiles/ndcs
    ${SDK_BASE}/components/profiles/otas_c
    ${SDK_BASE}/components/profiles/pass
    ${SDK_BASE}/components/profiles/pass_c
    ${SDK_BASE}/components/profiles/pcs
    ${SDK_BASE}/components/profiles/rscs
    ${SDK_BASE}/components/profiles/rscs_c
    ${SDK_BASE}/components/profiles/rtus
    ${SDK_BASE}/components/profiles/sample
    ${SDK_BASE}/components/profiles/ths
    ${SDK_BASE}/components/profiles/ths_c
    ${SDK_BASE}/components/profiles/thscps
    ${SDK_BASE}/components/profiles/tps
    ${SDK_BASE}/components/profiles/wechat
    ${SDK_BASE}/components/sdk/
    ${SDK_BASE}/drivers/inc
    ${SDK_BASE}/drivers/inc/hal
    ${SDK_BASE}/external/freertos/include
    ${SDK_BASE}/external/freerto/portable/GCC/ARM_CM4F
    ${SDK_BASE}/external/segger_rtt
    ${SDK_BASE}/platform/arch/arm/cortex-m/cmsis/core/include
    ${SDK_BASE}/platform/boards
    ${SDK_BASE}/platform/include
    ${SDK_BASE}/platform/soc/include
    ${SDK_BASE}/platform/soc/linker/keil
)

application_sources(
    ${SDK_BASE}/platform/arch/arm/cortex-m/gcc/startup_gr55xx.s
    ${SDK_BASE}/platform/boards/board_SK.c
    ${SDK_BASE}/platform/soc/common/gr_interrupt.c
    ${SDK_BASE}/platform/soc/common/gr_platform.c
    ${SDK_BASE}/platform/soc/common/gr_system.c
    ${SDK_BASE}/platform/soc/src/gr_soc.c
)

find_library(ble_sdk ble_sdk ${SDK_BASE}/platform/soc/linker/gcc/)



add_subdirectory(external)
add_subdirectory(drivers)
add_subdirectory(components)

# set(APPLICATION_NAME_ELF ${CMAKE_PROJECT_NAME}.elf CACHE STRING "Full application name." FORCE)

set(LINK_SCRIPT "")

list_append_ifdef(CONFIG_GR5515_SOC LINK_SCRIPT ${SDK_BASE}/platform/soc/linker/gcc/gcc_linker_gr5515.lds)
list_append_ifdef(CONFIG_GR5513_SOC LINK_SCRIPT ${SDK_BASE}/platform/soc/linker/gcc/gcc_linker_gr5513.lds)


list(APPEND LINK_SCRIPT ${SDK_BASE}/platform/soc/linker/gcc/rom_symbol_gcc.txt)

message(STATUS "APPLICATION_NAME_ELF: ${APPLICATION_NAME_ELF}")


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
    ${ble_sdk}
    sdk_interface
    )

# set_target_properties(${APPLICATION_NAME_ELF} PROPERTIES LINK_FLAGS "-Wl,--start-group -Wl,--end-group")

include(cmake/gr5xxx-postbuild.cmake)

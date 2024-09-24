cmake_minimum_required(VERSION 3.10)
# 指定编译平台/架构与语言标准
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_SYSTEM_VERSION 1)

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
set(CMAKE_C_COMPILER_WORKS TURE)
set(CMAKE_CXX_COMPILER_WORKS TURE)

set(CMAKE_C_COMPILER   arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER arm-none-eabi-g++)
set(CMAKE_ASM_COMPILER arm-none-eabi-gcc)
set(CMAKE_OBJCOPY      arm-none-eabi-objcopy)
set(CMAKE_OBJDUMP      arm-none-eabi-objdump)
set(CMAKE_AR           arm-none-eabi-ar)

project(ble_app_hrs C ASM)
# set(CMAKE_C_STANDARD 11)
# set(CMAKE_C_STANDARD_REQUIRED OFF)
# set(CMAKE_C_EXTENSIONS OFF)
# message(${CMAKE_C_COMPILE_OBJECT})
# message(${CMAKE_C_ARCHIVE_CREATE})
# message(${CMAKE_C_ARCHIVE_FINISH})
set(CMAKE_BUILD_TYPE "Release")

set(ELF_TARGET ${CMAKE_PROJECT_NAME}.elf)

add_compile_options(-std=gnu99 --inline -ggdb3 -ffunction-sections -fdata-sections -mfloat-abi=softfp -mfpu=fpv4-sp-d16  -mapcs-frame -mthumb-interwork -mthumb -mcpu=cortex-m4 -gdwarf-2 -g3)

set(LINK_SCRIPT 
    ${CMAKE_SOURCE_DIR}/../../../../../platform/soc/linker/gcc/gcc_linker_gr5515.lds
    ${CMAKE_SOURCE_DIR}/../../../../../platform/soc/linker/gcc/rom_symbol_gcc.txt
    
    )

include_directories(${ELF_TARGET}
    ../Src/config
    ../Src/platform
    ../Src/user
    ../Src/config
    ../../../../../components/boards
    ../../../../../components/drivers_ext/gr55xx
    ../../../../../components/drivers_ext/st7735
    ../../../../../components/drivers_ext/vs1005
    ../../../../../components/libraries/app_alarm
    ../../../../../components/libraries/app_assert
    ../../../../../components/libraries/app_error
    ../../../../../components/libraries/app_key
    ../../../../../components/libraries/app_log
    ../../../../../components/libraries/app_queue
    ../../../../../components/libraries/app_timer
    ../../../../../components/libraries/at_cmd
    ../../../../../components/libraries/gui
    ../../../../../components/libraries/gui/gui_config
    ../../../../../components/libraries/hal_flash
    ../../../../../components/libraries/fault_trace
    ../../../../../components/libraries/hci_uart
    ../../../../../components/libraries/pmu_calibration
    ../../../../../components/libraries/ring_buffer
    ../../../../../components/libraries/sensorsim
    ../../../../../components/libraries/utility
    ../../../../../components/patch/ind
    ../../../../../components/profiles/ams_c
    ../../../../../components/profiles/ancs_c
    ../../../../../components/profiles/ans
    ../../../../../components/profiles/ans_c
    ../../../../../components/profiles/bas
    ../../../../../components/profiles/bas_c
    ../../../../../components/profiles/bcs
    ../../../../../components/profiles/bps
    ../../../../../components/profiles/common
    ../../../../../components/profiles/cscs
    ../../../../../components/profiles/cts
    ../../../../../components/profiles/cts_c
    ../../../../../components/profiles/dis
    ../../../../../components/profiles/dis_c
    ../../../../../components/profiles/gls
    ../../../../../components/profiles/gus
    ../../../../../components/profiles/gus_c
    ../../../../../components/profiles/hids
    ../../../../../components/profiles/hrrcps
    ../../../../../components/profiles/hrs
    ../../../../../components/profiles/hrs_c
    ../../../../../components/profiles/hts
    ../../../../../components/profiles/ias
    ../../../../../components/profiles/lls
    ../../../../../components/profiles/lns
    ../../../../../components/profiles/ndcs
    ../../../../../components/profiles/otas_c
    ../../../../../components/profiles/pass
    ../../../../../components/profiles/pass_c
    ../../../../../components/profiles/pcs
    ../../../../../components/profiles/rscs
    ../../../../../components/profiles/rscs_c
    ../../../../../components/profiles/rtus
    ../../../../../components/profiles/sample
    ../../../../../components/profiles/ths
    ../../../../../components/profiles/ths_c
    ../../../../../components/profiles/thscps
    ../../../../../components/profiles/tps
    ../../../../../components/profiles/wechat
    ../../../../../components/sdk/
    ../../../../../drivers/inc
    ../../../../../drivers/inc/hal
    ../../../../../external/freertos/include
    ../../../../../external/segger_rtt
    ../../../../../platform/arch/arm/cortex-m/cmsis/core/include
    ../../../../../platform/boards
    ../../../../../platform/include
    ../../../../../platform/soc/include
    ../../../../../platform/soc/linker/keil
)

add_executable(${ELF_TARGET})

target_sources(${ELF_TARGET} PUBLIC
    ../../../../../platform/soc/common/gr_system.c
    ../../../../../platform/soc/common/gr_interrupt.c
    ../../../../../platform/soc/common/gr_platform.c
    ../../../../../platform/soc/src/gr_soc.c
    ../../../../../platform/boards/board_SK.c
    ../../../../../drivers/src/app_dma.c
    ../../../../../drivers/src/app_gpiote.c
    ../../../../../drivers/src/app_io.c
    ../../../../../drivers/src/app_pwr_mgmt.c
    ../../../../../drivers/src/app_uart.c
    ../../../../../drivers/src/app_uart_dma.c
    ../../../../../components/libraries/utility/utility.c
    ../../../../../components/libraries/sensorsim/sensorsim.c
    ../../../../../components/libraries/app_timer/app_timer.c
    ../../../../../components/libraries/app_log/app_log.c
    ../../../../../components/libraries/app_assert/app_assert.c
    ../../../../../components/libraries/app_error/app_error.c
    ../../../../../components/libraries/ring_buffer/ring_buffer.c
    ../../../../../components/libraries/pmu_calibration/pmu_calibration.c
    ../../../../../components/libraries/hci_uart/hci_uart.c
    ../../../../../components/libraries/app_key/app_key.c
    ../../../../../components/libraries/app_key/app_key_core.c
    ../../../../../components/libraries/fault_trace/fault_trace.c
    ../../../../../components/libraries/app_error/cortex_backtrace.c
    ../../../../../components/sdk/ble.c
    ../../../../../components/profiles/common/ble_prf_utils.c
    ../../../../../components/profiles/bas/bas.c
    ../../../../../components/profiles/dis/dis.c
    ../../../../../components/profiles/hrs/hrs.c
    ../../../../../components/profiles/lns/lns.c
    ../../../../../external/segger_rtt/SEGGER_RTT.c
    ../Src/platform/user_periph_setup.c
    ../Src/user/main.c
    ../Src/user/user_app.c

    ../../../../../platform/arch/arm/cortex-m/gcc/startup_gr55xx.s
)

target_link_options(${ELF_TARGET} PUBLIC
    -T${LINK_SCRIPT}
    -mcpu=cortex-m4
    --specs=nosys.specs
    -Wl,--gc-sections    
    -Wl,-Map=${CMAKE_PROJECT_NAME}.map
    -Wl,--cref
    -Wl,--print-memory-usage

)

find_library(ble_sdk       ble_sdk ../../../../../platform/soc/linker/gcc/)

target_link_libraries(${ELF_TARGET} PUBLIC 
    ${ble_sdk}
    )

add_custom_command(TARGET ${ELF_TARGET} POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O ihex ${ELF_TARGET} ${CMAKE_PROJECT_NAME}.hex
    COMMAND ${CMAKE_OBJCOPY} -O binary -S ${ELF_TARGET} ${CMAKE_PROJECT_NAME}.bin
)

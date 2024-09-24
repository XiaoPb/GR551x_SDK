/**
 ****************************************************************************************
 *
 * @file custom_config.h
 *
 * @brief Custom configuration file for applications.
 *
 ****************************************************************************************
 * @attention
  #####Copyright (c) 2019 GOODIX
  All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:
  * Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.
  * Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.
  * Neither the name of GOODIX nor the names of its contributors may be used
    to endorse or promote products derived from this software without
    specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
  ARE DISCLAIMED. IN NO EVENT SHALL COPYRIGHT HOLDERS AND CONTRIBUTORS BE
  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  POSSIBILITY OF SUCH DAMAGE.
 *****************************************************************************************
 */

/*
 * DEFINES
 *****************************************************************************************
 */
#ifndef __CUSTOM_CONFIG_H__
#define __CUSTOM_CONFIG_H__
#include "autoconf.h"
// <<< Use Configuration Wizard in Context Menu >>>

// <h> Basic configuration


#if (CONFIG_CHIP_SOC == 0)
// <o> Chip version
#ifndef SOC_GR5515
#define SOC_GR5515
#endif

// <o> Select chip type
// <0=> GR5515IGND
// <1=> GR5515IENDU
// <2=> GR5515I0ND
// <3=> GR5515I0NDA
// <4=> GR5515RGBD
// <5=> GR5515GGBD
// <6=> GR5513BEND
// <7=> GR5513BENDU
#ifndef CHIP_TYPE
#define CHIP_TYPE  CONFIG_CHIP_TYPE
#endif

#elif (CONFIG_CHIP_SOC == 1)

// <o> Chip version
#ifndef SOC_GR5X25
#define SOC_GR5X25
#endif

#elif (CONFIG_CHIP_SOC == 2)

// <o> Chip version
#ifndef SOC_GR5526
#define SOC_GR5526
#endif

#elif (CONFIG_CHIP_SOC == 3)

// <o> Chip version
#ifndef SOC_GR533X
#define SOC_GR533X
#endif

// <o> Select chip type
// <0=> GR5330ACNI
// <1=> GR5331AENI
// <2=> GR5331CENI
// <3=> GR5332AENE
// <4=> GR5332CENE
#ifndef CHIP_TYPE
#define CHIP_TYPE                        4
#endif

#elif (CONFIG_CHIP_SOC == 4)

// <o> Chip version
#ifndef SOC_GR5405
#define SOC_GR5405
#endif

#endif

// <o> Enable encrypt chip
// <0=> DISABLE
// <1=> ENABLE
#ifndef ENCRYPT_ENABLE
#define ENCRYPT_ENABLE  CONFIG_ENCRYPT_ENABLE
#endif

// <o> Enable the external flash of chip
// <0=> DISABLE
// <1=> ENABLE
#ifndef EXT_EXFLASH_ENABLE
#define EXT_EXFLASH_ENABLE       CONFIG_EXT_EXFLASH_ENABLE
#endif

// <o> Enable the platform initialization process
// <0=> DISABLE
// <1=> ENABLE
#ifndef PLATFORM_INIT_ENABLE
#define PLATFORM_INIT_ENABLE      CONFIG_PLATFORM_INIT_ENABLE
#endif

// <o> Enable system fault trace module
// <0=> DISABLE
// <1=> ENABLE
#ifndef SYS_FAULT_TRACE_ENABLE
#define SYS_FAULT_TRACE_ENABLE    CONFIG_SYS_FAULT_TRACE_ENABLE
#endif

// <o> Enable callstack backtrace function
// <i> Default: 0
#ifndef ENABLE_BACKTRACE_FEA
#define ENABLE_BACKTRACE_FEA      CONFIG_ENABLE_BACKTRACE_FEA
#endif

// <o> Enable APP driver module
// <0=> DISABLE
// <1=> ENABLE
#ifndef APP_DRIVER_USE_ENABLE
#define APP_DRIVER_USE_ENABLE     CONFIG_APP_DRIVER_USE_ENABLE
#endif

// <o> Eanble APP log module
// <0=> DISABLE
// <1=> ENABLE
#ifndef APP_LOG_ENABLE
#define APP_LOG_ENABLE            CONFIG_APP_LOG_ENABLE
#endif

// <o> APP log port type
// <0=> UART
// <1=> RTT
// <2=> ITM
#ifndef APP_LOG_PORT
#define APP_LOG_PORT              CONFIG_APP_LOG_PORT
#endif

// <o> Eanble APP log store module
// <0=> DISABLE
// <1=> ENABLE
#ifndef APP_LOG_STORE_ENABLE
#define APP_LOG_STORE_ENABLE      CONFIG_APP_LOG_STORE_ENABLE
#endif

#if     (CHIP_TYPE == 4)
// <o> Enable SK GUI module, only available in GR5515
// <0=> DISABLE
// <1=> ENABLE
#ifndef SK_GUI_ENABLE
#define SK_GUI_ENABLE             CONFIG_SK_GUI_ENABLE
#endif
#endif

// <o> Enable debug monitor module
// <0=> DISABLE
// <1=> ENABLE
#ifndef DEBUG_MONITOR
#define DEBUG_MONITOR             CONFIG_DEBUG_MONITOR
#endif

// <o> Enable DTM test support
// <0=> DISABLE
// <1=> ENABLE
#ifndef DTM_TEST_ENABLE
#define DTM_TEST_ENABLE           CONFIG_DTM_TEST_ENABLE
#endif

// <o> Protection priority level
// <i> Default:  0
#ifndef FLASH_PROTECT_PRIORITY
#define FLASH_PROTECT_PRIORITY    CONFIG_FLASH_PROTECT_PRIORITY
#endif

// <o> NVDS Start Address
// <i> Default:  0x010FF000
#ifndef NVDS_START_ADDR
#define NVDS_START_ADDR           CONFIG_NVDS_START_ADDR
#endif

// <o> The Number of sectors for NVDS
// <i> Default:  1
// <i> Range: 1-16
#ifndef NVDS_NUM_SECTOR
#define NVDS_NUM_SECTOR          CONFIG_NVDS_NUM_SECTOR
#endif

// <o> Call Stack Size
// <i> Default: 0x4000
#ifndef SYSTEM_STACK_SIZE
#define SYSTEM_STACK_SIZE       CONFIG_SYSTEM_STACK_SIZE
#endif

// <o> Call Heap Size
// <i> Default: 0x1000
#ifndef SYSTEM_HEAP_SIZE
#define SYSTEM_HEAP_SIZE        CONFIG_SYSTEM_HEAP_SIZE
#endif

// </h>

// <h> Boot info configuration
// <o> Chip version
// <i> Default: 0x00

// <o> Chip version
// <i> Default: 0x00
#ifndef CHIP_VER
#define CHIP_VER                CONFIG_CHIP_VER
#endif

// <o> Code load address
// <0x30004100=> SRAM address
// <0x01002000=> Flash address
// <i> Default:  0x01002000
#ifndef APP_CODE_LOAD_ADDR
#define APP_CODE_LOAD_ADDR      CONFIG_APP_CODE_LOAD_ADDR
#endif

// <o> Code run address
// <0x30004100=> SRAM address
// <0x01002000=> Flash address
// <i> Default:  0x01002000
#ifndef APP_CODE_RUN_ADDR
#define APP_CODE_RUN_ADDR       CONFIG_APP_CODE_RUN_ADDR
#endif

// <ol.0..5> System clock
// <0=> 64MHZ
// <1=> 48MHZ
// <2=> 16MHZ-XO
// <3=> 24MHZ
// <4=> 16MHZ
// <5=> 32MHZ-CPLL
#ifndef SYSTEM_CLOCK
#define SYSTEM_CLOCK            CONFIG_SYSTEM_CLOCK
#endif

// <o> External clock accuracy used in the LL to compute timing  <1-500>
// <i> Range: 1-500
#ifndef CFG_LF_ACCURACY_PPM
#define CFG_LF_ACCURACY_PPM     CONFIG_CFG_LF_ACCURACY_PPM
#endif

// <o> Enable internal osc as low power clock
// <0=> Default: Disable internal osc as low power clock
// <1=> Enable internal osc as low power clock and force CFG_LF_ACCURACY_PPM to 500ppm
#ifndef CFG_LPCLK_INTERNAL_EN
#define CFG_LPCLK_INTERNAL_EN   CONFIG_CFG_LPCLK_INTERNAL_EN
#endif

// <o> Delay time for Crystal stabilization time
// <i> Default:  100
// <i> Range: 100-500
// <i> Note: Set according to actual measurement data
#ifndef CFG_CRYSTAL_DELAY
#define CFG_CRYSTAL_DELAY       CONFIG_CFG_CRYSTAL_DELAY
#endif

// <o> Delay time for Boot startup
// <0=> Not Delay
// <1=> Delay 1s
#ifndef BOOT_LONG_TIME
#define BOOT_LONG_TIME          CONFIG_BOOT_LONG_TIME
#endif

// <o> In xip mode, check image during cold boot startup
// <0=> Not check
// <1=> Check image
#ifndef BOOT_CHECK_IMAGE
#define BOOT_CHECK_IMAGE        CONFIG_BOOT_CHECK_IMAGE
#endif

// <o> Delay time between flash wakeup and read chip id in warm boot
// <i> Default:  0
// <i> Range: 0-10
// <i> Note:
// <0=> No delay
// <1=> Delay 5 us
// <2=> Delay 10 us
// <3=> Delay 15 us
// <4=> Delay 20 us
// <5=> Delay 25 us
#ifndef EXFLASH_WAKEUP_DELAY
#define EXFLASH_WAKEUP_DELAY              CONFIG_EXFLASH_WAKEUP_DELAY
#endif

// </h>

// <h> BLE resource configuration
// <i> Note: The total number of BLE Activities(CONNECTIONS+ADVS+SCAN) should not exceed the limit 12.

// <o> Support maximum number of BLE profiles <1-64>
// <i> Range: 1-64
#ifndef CFG_MAX_PRFS
#define CFG_MAX_PRFS             CONFIG_CFG_MAX_PRFS
#endif

// <o> Support maximum number of bonded devices
#ifndef CFG_MAX_BOND_DEVS
#define CFG_MAX_BOND_DEVS        CONFIG_CFG_MAX_BOND_DEVS
#endif

// <o> Support the configuration of the number of scan duplicate filter lists
// <i> Range: 0-50
#ifndef CFG_SCAN_DUP_FILT_LIST_NUM
#define CFG_SCAN_DUP_FILT_LIST_NUM       CONFIG_CFG_SCAN_DUP_FILT_LIST_NUM
#endif

// <o> Support maximum number of BLE Links <1-10>
// <i> Range: 1-10
#ifndef CFG_MAX_CONNECTIONS
#define CFG_MAX_CONNECTIONS      CONFIG_CFG_MAX_CONNECTIONS
#endif

// <o> Support maximum number of BLE Legacy/Extended Advertisings <0-5>
// <i> Range: 0-5
// <i> Note: The total number of BLE Legacy/Extended/Periodic Advertisings should not exceed the limit 5.
#ifndef CFG_MAX_ADVS
#define CFG_MAX_ADVS             CONFIG_CFG_MAX_ADVS
#endif

// <o> Support 31 bytes adv data for legacy adv
// <0=> NOT SUPPORT
// <1=> SUPPORT
#ifndef CFG_MAX_ADV_DATA_LEN_SUPPORT
#define CFG_MAX_ADV_DATA_LEN_SUPPORT        CONFIG_CFG_MAX_ADV_DATA_LEN_SUPPORT
#endif

// <o> Support maximum number of BLE Periodic Advertisings <0-5>
// <i> Range: 0-5
// <i> Note: The total number of BLE Legacy/Extended/Periodic Advertisings should not exceed the limit 5.
#ifndef CFG_MAX_PER_ADVS
#define CFG_MAX_PER_ADVS          CONFIG_CFG_MAX_PER_ADVS
#endif

// <o> Support maximum number of BLE Periodic Advertising Synchronizations <0-5>
// <i> Range: 0-5
#ifndef CFG_MAX_SYNCS
#define CFG_MAX_SYNCS             CONFIG_CFG_MAX_SYNCS
#endif

// <o> Support maximum number of BLE Scan <0-1>
// <i> Range: 0-1
#ifndef CFG_MAX_SCAN
#define CFG_MAX_SCAN             CONFIG_CFG_MAX_SCAN
#endif

// <o>  Support BT-BR/EDR
// <0=> NOT SUPPORT
// <1=> SUPPORT
#ifndef CFG_BT_BREDR
#define CFG_BT_BREDR                      CONFIG_CFG_BT_BREDR
#endif

// <o>  Support multiple link with the same device
// <0=> NOT SUPPORT
// <1=> SUPPORT
#ifndef CFG_MUL_LINK_WITH_SAME_DEV
#define CFG_MUL_LINK_WITH_SAME_DEV        CONFIG_CFG_MUL_LINK_WITH_SAME_DEV
#endif

// <o>  Support car key needs
// <0=> NOT SUPPORT
// <1=> SUPPORT
#ifndef CFG_CAR_KEY_SUPPORT
#define CFG_CAR_KEY_SUPPORT               CONFIG_CFG_CAR_KEY_SUPPORT
#endif
// </h>

// <h>  MESH support configuration
// <o>  Support MESH
// <0=> NOT SUPPORT
// <1=> SUPPORT
#ifndef CFG_MESH_SUPPORT
#define CFG_MESH_SUPPORT          CONFIG_CFG_MESH_SUPPORT
#endif
// </h>

// <h>  LCP support configuration
// <o>  Support LCP
// <0=> NOT SUPPORT
// <1=> SUPPORT
#ifndef CFG_LCP_SUPPORT
#define CFG_LCP_SUPPORT           CONFIG_CFG_LCP_SUPPORT
#endif
// </h>

// <h>  Security configuration
// <o>  Algorithm security level
// <0=> Enable algorithm level one
// <1=> Enable algorithm level two
#ifndef SECURITY_CFG_VAL
#define SECURITY_CFG_VAL         CONFIG_SECURITY_CFG_VAL
#endif
// </h>

// <<< end of configuration section >>>
#endif //__CUSTOM_CONFIG_H__

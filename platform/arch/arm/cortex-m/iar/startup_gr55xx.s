;/**************************************************************************//**
; * @file     startup_ARMCM4.s
; * @brief    CMSIS Core Device Startup File for
; *           ARMCM4 Device Series
; * @version  V5.00
; * @date     08. March 2016
; ******************************************************************************/
;/*
; * Copyright (c) 2009-2016 ARM Limited. All rights reserved.
; *
; * SPDX-License-Identifier: Apache-2.0
; *
; * Licensed under the Apache License, Version 2.0 (the License); you may
; * not use this file except in compliance with the License.
; * You may obtain a copy of the License at
; *
; * www.apache.org/licenses/LICENSE-2.0
; *
; * Unless required by applicable law or agreed to in writing, software
; * distributed under the License is distributed on an AS IS BASIS, WITHOUT
; * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
; * See the License for the specific language governing permissions and
; * limitations under the License.
; */

;
; The modules in this file are included in the libraries, and may be replaced
; by any user-defined modules that define the PUBLIC symbol _program_start or
; a user defined start symbol.
; To override the cstartup defined in the library, simply add your modified
; version to the workbench project.
;
; The vector table is normally located at address 0.
; When debugging in RAM, it can be located in RAM, aligned to at least 2^6.
; The name "__vector_table" has special meaning for C-SPY:
; it is where the SP start value is found, and the NVIC vector
; table register (VTOR) is initialized to this address if != 0.
;
; Cortex-M version
;

        MODULE  ?cstartup

        ;; Forward declaration of sections.
        SECTION CSTACK:DATA:NOROOT(3)

        SECTION .intvec:CODE:NOROOT(2)

        EXTERN  __iar_program_start
        EXTERN  SystemInit
        EXTERN  main_init

        PUBLIC  __vector_table
        PUBLIC  __Vectors
        PUBLIC  __Vectors_End
        PUBLIC  __Vectors_Size

        DATA

__vector_table
        DCD     sfe(CSTACK)
        DCD     Reset_Handler

        DCD     NMI_Handler_local
        DCD     HardFault_Handler_local
        DCD     MemManage_Handler_local
        DCD     BusFault_Handler_local
        DCD     UsageFault_Handler_local
        DCD     0
        DCD     0
        DCD     0
        DCD     0
        DCD     SVC_Handler_local
        DCD     DebugMon_Handler_local
        DCD     0
        DCD     PendSV_Handler_local
        DCD     SysTick_Handler_local
__Vectors_End

__Vectors       EQU   __vector_table
__Vectors_Size  EQU   __Vectors_End - __Vectors


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Default interrupt handlers.
;;
        THUMB

        PUBWEAK Reset_Handler
        SECTION .text:CODE:REORDER:NOROOT(2)
Reset_Handler
        LDR     R0, =SystemInit
        BLX     R0
        LDR     R0, =main_init
        BX      R0

        PUBWEAK NMI_Handler_local
        SECTION .text:CODE:REORDER:NOROOT(1)
NMI_Handler_local
        B NMI_Handler_local

        PUBWEAK HardFault_Handler_local
        SECTION .text:CODE:REORDER:NOROOT(1)
HardFault_Handler_local
        B HardFault_Handler_local

        PUBWEAK MemManage_Handler_local
        SECTION .text:CODE:REORDER:NOROOT(1)
MemManage_Handler_local
        B MemManage_Handler_local

        PUBWEAK BusFault_Handler_local
        SECTION .text:CODE:REORDER:NOROOT(1)
BusFault_Handler_local
        B BusFault_Handler_local

        PUBWEAK UsageFault_Handler_local
        SECTION .text:CODE:REORDER:NOROOT(1)
UsageFault_Handler_local
        B UsageFault_Handler_local

        PUBWEAK SVC_Handler_local
        SECTION .text:CODE:REORDER:NOROOT(1)
SVC_Handler_local
        B SVC_Handler_local

        PUBWEAK DebugMon_Handler_local
        SECTION .text:CODE:REORDER:NOROOT(1)
DebugMon_Handler_local
        B DebugMon_Handler_local

        PUBWEAK PendSV_Handler_local
        SECTION .text:CODE:REORDER:NOROOT(1)
PendSV_Handler_local
        B PendSV_Handler_local

        PUBWEAK SysTick_Handler_local
        SECTION .text:CODE:REORDER:NOROOT(1)
SysTick_Handler_local
        B SysTick_Handler_local
        END
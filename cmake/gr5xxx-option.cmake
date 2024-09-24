cmake_minimum_required(VERSION 3.10)
# generate flags from user variables
if(CMAKE_BUILD_TYPE MATCHES Debug)
set(DBG_FLAGS "-g3 -gdwarf-2 -O0")
elseif(CMAKE_BUILD_TYPE MATCHES Release)
set(DBG_FLAGS "-Os")
endif()

set(MCU_FLAGS "-mfloat-abi=softfp -mfpu=fpv4-sp-d16 -mapcs-frame -mthumb-interwork -mthumb -mcpu=cortex-m4")

# stm32 gcc common flags
# message(STATUS "MCU_FLAGS: ${MCU_FLAGS}")
# message(STATUS "DBG_FLAGS: ${DBG_FLAGS}")

# compiler: language specific flags -MD -Wno-attributes
# set(CMAKE_C_FLAGS "-std=gnu99 --inline -ggdb3 -ffunction-sections -fdata-sections ${MCU_FLAGS} -gdwarf-2 ${DBG_FLAGS} " CACHE INTERNAL "C compiler flags")
# set(CMAKE_C_FLAGS_DEBUG "" CACHE INTERNAL "C compiler flags: Debug")
# set(CMAKE_C_FLAGS_RELEASE "" CACHE INTERNAL "C compiler flags: Release")

# set(CMAKE_CXX_FLAGS "-std=gnu99 --inline -ggdb3 -ffunction-sections -fdata-sections ${MCU_FLAGS} -gdwarf-2 ${DBG_FLAGS} " CACHE INTERNAL "Cxx compiler flags")
# set(CMAKE_CXX_FLAGS_DEBUG "" CACHE INTERNAL "Cxx compiler flags: Debug")
# set(CMAKE_CXX_FLAGS_RELEASE "" CACHE INTERNAL "Cxx compiler flags: Release")

# set(CMAKE_ASM_FLAGS "-std=gnu99 --inline -ggdb3 -ffunction-sections -fdata-sections ${MCU_FLAGS} -gdwarf-2 ${DBG_FLAGS} " CACHE INTERNAL "ASM compiler flags")
# set(CMAKE_ASM_FLAGS_DEBUG "" CACHE INTERNAL "ASM compiler flags: Debug")
# set(CMAKE_ASM_FLAGS_RELEASE "" CACHE INTERNAL "ASM compiler flags: Release")
add_compile_options(-std=gnu99 --inline -ggdb3 -ffunction-sections -fdata-sections -mfloat-abi=softfp -mfpu=fpv4-sp-d16  -mapcs-frame -mthumb-interwork -mthumb -mcpu=cortex-m4 -gdwarf-2)


# set(LINK_FLAGS "-mcpu=cortex-m4 --specs=nosys.specs -Wl,--gc-sections")

# set(CMAKE_EXE_LINKER_FLAGS "${LINK_FLAGS}" CACHE INTERNAL "Exe linker flags")
# set(CMAKE_SHARED_LINKER_FLAGS "${LINK_FLAGS}" CACHE INTERNAL "Shared linker flags")


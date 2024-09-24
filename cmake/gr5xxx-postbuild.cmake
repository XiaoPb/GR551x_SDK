set(PROJECT_NAME ${APPLICATION_NAME})
# name of targets
set(BIN_TARGET ${PROJECT_NAME}.bin)
set(HEX_TARGET ${PROJECT_NAME}.hex)
set(MAP_TARGET ${PROJECT_NAME}.map)
set(LSS_TARGET ${PROJECT_NAME}.lss)

# create binary & hex files and show size of resulting firmware image
add_custom_command(TARGET ${PROJECT_NAME}.elf POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -O ihex $<TARGET_FILE:${PROJECT_NAME}.elf> ../${HEX_TARGET}
        COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:${PROJECT_NAME}.elf> ../${BIN_TARGET}
        COMMAND ${ARM_OBJDUMP_EXECUTABLE} -S $<TARGET_FILE:${PROJECT_NAME}.elf> > ../${LSS_TARGET}
        COMMAND ${ARM_SIZE_EXECUTABLE} -B ${PROJECT_NAME}.elf
        COMMENT "Generating ${HEX_TARGET}, ${BIN_TARGET}")

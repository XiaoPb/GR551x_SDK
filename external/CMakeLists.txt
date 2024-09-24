

# sdk_library()
# sdk_include_directories(
#     ${CMAKE_CURRENT_SOURCE_DIR}/segger_rtt
#     ${CMAKE_CURRENT_SOURCE_DIR}/freerto/portable/GCC/ARM_CM4F
#     ${CMAKE_CURRENT_SOURCE_DIR}/freerto/include

# )
application_sources_ifdef(CONFIG_SEGGER_RTT
    segger_rtt/SEGGER_RTT.c
)
#sdk_library_link_libraries(
#    drivers
#)
# target_link_libraries(sdk PUBLIC ${SDK_CURRENT_LIBRARY})

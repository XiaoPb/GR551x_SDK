sdk_library()
sdk_include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)
sdk_library_sources(
    ${CMAKE_CURRENT_SOURCE_DIR}/app_alarm.c
)

target_link_libraries(sdk PUBLIC 
    ${CMAKE_CURRENT_SOURCE_DIR}/cmsis_dsp/Lib/GCC/libarm_cortexM4lf_math.a
)

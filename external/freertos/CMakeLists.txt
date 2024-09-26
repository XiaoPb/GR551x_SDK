
sdk_library()
sdk_include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    ${CMAKE_CURRENT_SOURCE_DIR}/portable/GCC/ARM_CM4F

)
sdk_library_sources(
    portable/GR55XX/port_pm.c
    portable/GCC/ARM_CM4F/port.c
    croutine.c
    event_groups.c
    heap_4.c
    list.c
    queue.c
    stream_buffer.c
    tasks.c
    timers.c
)
sdk_library_link_libraries(
   drivers
)
target_link_libraries(sdk PUBLIC ${SDK_CURRENT_LIBRARY})

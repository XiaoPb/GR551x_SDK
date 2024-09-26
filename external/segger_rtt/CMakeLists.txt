
sdk_library()
sdk_include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}/

)
sdk_library_sources(
    SEGGER_RTT.c
)
sdk_library_link_libraries(
   drivers
)
target_link_libraries(sdk PUBLIC ${SDK_CURRENT_LIBRARY})

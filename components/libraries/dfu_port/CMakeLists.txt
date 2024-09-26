sdk_library()
sdk_include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}/
)
sdk_library_sources(
    ${CMAKE_CURRENT_SOURCE_DIR}/dfu_port.c
)

target_link_libraries(sdk PUBLIC ${SDK_CURRENT_LIBRARY})

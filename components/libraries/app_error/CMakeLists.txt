# sdk_library()
# sdk_include_directories(
#     ${CMAKE_CURRENT_SOURCE_DIR}/
# )
application_sources(
    ${CMAKE_CURRENT_SOURCE_DIR}/app_error.c
    ${CMAKE_CURRENT_SOURCE_DIR}/cortex_backtrace.c
)
# target_link_libraries(sdk PUBLIC ${SDK_CURRENT_LIBRARY})

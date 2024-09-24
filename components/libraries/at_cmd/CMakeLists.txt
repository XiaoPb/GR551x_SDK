# sdk_library()
# sdk_include_directories(
#     ${CMAKE_CURRENT_SOURCE_DIR}/
# )
application_sources(
    ${CMAKE_CURRENT_SOURCE_DIR}/at_cmd.c
    ${CMAKE_CURRENT_SOURCE_DIR}/at_cmd_utils.c
)
# target_link_libraries(sdk PUBLIC ${SDK_CURRENT_LIBRARY})

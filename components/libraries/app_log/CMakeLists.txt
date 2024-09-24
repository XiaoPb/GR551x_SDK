# sdk_library()
# sdk_include_directories(
#     ${CMAKE_CURRENT_SOURCE_DIR}/
# )
application_sources(
    ${CMAKE_CURRENT_SOURCE_DIR}/app_log.c
)
# sdk_library_link_libraries(
#     drivers
# )
application_sources_ifdef(CONFIG_APP_LOG_STORE_ENABLE ${CMAKE_CURRENT_SOURCE_DIR}/app_log_store.c) 
application_sources_ifdef(CONFIG_APP_LOG_STORE_ENABLE ${CMAKE_CURRENT_SOURCE_DIR}/app_log_dump_port.c) 
# target_link_libraries(sdk PUBLIC ${SDK_CURRENT_LIBRARY})

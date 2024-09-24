# # sdk_library()
# sdk_include_directories(
#     ${CMAKE_CURRENT_SOURCE_DIR}/
# )
# application_sources(
#     ${CMAKE_CURRENT_SOURCE_DIR}/app_alarm.c
# )

target_link_libraries(${APPLICATION_NAME_ELF} PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/gcc/libapp_crypto.a
)

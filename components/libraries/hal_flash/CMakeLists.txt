# sdk_library()
# sdk_include_directories(
#     ${CMAKE_CURRENT_SOURCE_DIR}/
#     ${CMAKE_CURRENT_SOURCE_DIR}/vflash
# )
application_sources(
    ${CMAKE_CURRENT_SOURCE_DIR}/hal_flash.c
    ${CMAKE_CURRENT_SOURCE_DIR}/hal_exflash_user_operation.c
    ${CMAKE_CURRENT_SOURCE_DIR}/vflash/vflash.c
)
# target_link_libraries(sdk PUBLIC ${SDK_CURRENT_LIBRARY})

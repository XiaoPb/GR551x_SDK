# sdk_library()
# sdk_include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}/inc
)
application_sources(
    ${CMAKE_CURRENT_SOURCE_DIR}/src/crypto_aes.c
    ${CMAKE_CURRENT_SOURCE_DIR}/src/crypto_ecc_port.c
    ${CMAKE_CURRENT_SOURCE_DIR}/src/crypto_ecc.c
    ${CMAKE_CURRENT_SOURCE_DIR}/src/crypto_gcm.c
    ${CMAKE_CURRENT_SOURCE_DIR}/src/crypto_pkc_port.c
    ${CMAKE_CURRENT_SOURCE_DIR}/src/crypto_pkc.c
    ${CMAKE_CURRENT_SOURCE_DIR}/src/crypto_rsa_port.c
    ${CMAKE_CURRENT_SOURCE_DIR}/src/crypto_rsa.c
    ${CMAKE_CURRENT_SOURCE_DIR}/src/crypto_sha256.c
)
# target_link_libraries(sdk PUBLIC ${SDK_CURRENT_LIBRARY})

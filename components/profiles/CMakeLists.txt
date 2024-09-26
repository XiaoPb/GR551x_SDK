sdk_library()
sdk_include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}/ags
    ${CMAKE_CURRENT_SOURCE_DIR}/ams_c
    ${CMAKE_CURRENT_SOURCE_DIR}/ancs_c
    ${CMAKE_CURRENT_SOURCE_DIR}/ans
    ${CMAKE_CURRENT_SOURCE_DIR}/ans_c
    ${CMAKE_CURRENT_SOURCE_DIR}/bas
    ${CMAKE_CURRENT_SOURCE_DIR}/bas_c
    ${CMAKE_CURRENT_SOURCE_DIR}/bcs
    ${CMAKE_CURRENT_SOURCE_DIR}/bps
    ${CMAKE_CURRENT_SOURCE_DIR}/common
    ${CMAKE_CURRENT_SOURCE_DIR}/cscs
    ${CMAKE_CURRENT_SOURCE_DIR}/cts
    ${CMAKE_CURRENT_SOURCE_DIR}/cts_c
    ${CMAKE_CURRENT_SOURCE_DIR}/dis
    ${CMAKE_CURRENT_SOURCE_DIR}/dis_c
    ${CMAKE_CURRENT_SOURCE_DIR}/dss
    ${CMAKE_CURRENT_SOURCE_DIR}/gls
    ${CMAKE_CURRENT_SOURCE_DIR}/gus
    ${CMAKE_CURRENT_SOURCE_DIR}/gus_c
    ${CMAKE_CURRENT_SOURCE_DIR}/hids
    ${CMAKE_CURRENT_SOURCE_DIR}/hrrcps
    ${CMAKE_CURRENT_SOURCE_DIR}/hrs
    ${CMAKE_CURRENT_SOURCE_DIR}/hrs_c
    ${CMAKE_CURRENT_SOURCE_DIR}/hts
    ${CMAKE_CURRENT_SOURCE_DIR}/ias
    ${CMAKE_CURRENT_SOURCE_DIR}/ias_c
    ${CMAKE_CURRENT_SOURCE_DIR}/lls
    ${CMAKE_CURRENT_SOURCE_DIR}/lls_c
    ${CMAKE_CURRENT_SOURCE_DIR}/lms
    ${CMAKE_CURRENT_SOURCE_DIR}/lns
    ${CMAKE_CURRENT_SOURCE_DIR}/mlmr
    ${CMAKE_CURRENT_SOURCE_DIR}/mlmr_c
    ${CMAKE_CURRENT_SOURCE_DIR}/ndcs
    ${CMAKE_CURRENT_SOURCE_DIR}/otas
    ${CMAKE_CURRENT_SOURCE_DIR}/otas_c
    ${CMAKE_CURRENT_SOURCE_DIR}/pass
    ${CMAKE_CURRENT_SOURCE_DIR}/pass_c
    ${CMAKE_CURRENT_SOURCE_DIR}/pcs
    ${CMAKE_CURRENT_SOURCE_DIR}/rscs
    ${CMAKE_CURRENT_SOURCE_DIR}/rscs_c
    ${CMAKE_CURRENT_SOURCE_DIR}/rtus
    ${CMAKE_CURRENT_SOURCE_DIR}/sample
    ${CMAKE_CURRENT_SOURCE_DIR}/ths
    ${CMAKE_CURRENT_SOURCE_DIR}/ths_c
    ${CMAKE_CURRENT_SOURCE_DIR}/tps
    ${CMAKE_CURRENT_SOURCE_DIR}/tps_c
    ${CMAKE_CURRENT_SOURCE_DIR}/uds
    ${CMAKE_CURRENT_SOURCE_DIR}/wss
)

sdk_library_sources_ifdef(CONFIG_AGS     ags/ags.c)
sdk_library_sources_ifdef(CONFIG_AMS_C   ams_c/ams_c.c)
sdk_library_sources_ifdef(CONFIG_ANCS_C  ancs_c/ancs_c.c)
sdk_library_sources_ifdef(CONFIG_ANCS_C  ancs_c/ancs_protocol.c)
sdk_library_sources_ifdef(CONFIG_ANS     ans/ans.c)
sdk_library_sources_ifdef(CONFIG_ANS_C   ans_c/ans_c.c)
sdk_library_sources_ifdef(CONFIG_BAS     bas/bas.c)
sdk_library_sources_ifdef(CONFIG_BAS_C   bas_c/bas_c.c)
sdk_library_sources_ifdef(CONFIG_BCS     bcs/bcs.c)
sdk_library_sources_ifdef(CONFIG_BPS     bps/bps.c)
sdk_library_sources_ifdef(CONFIG_BLE_COMMON  common/ble_prf_utils.c)
sdk_library_sources_ifdef(CONFIG_BLE_COMMON  common/ble_srv_disc_utils.c)
sdk_library_sources_ifdef(CONFIG_CSCS    cscs/cscs.c)
sdk_library_sources_ifdef(CONFIG_CTS     cts/cts.c)
sdk_library_sources_ifdef(CONFIG_CTS_C   cts_c/cts_c.c)
sdk_library_sources_ifdef(CONFIG_DIS     dis/dis.c)
sdk_library_sources_ifdef(CONFIG_DIS_C   dis_c/dis_c.c)
sdk_library_sources_ifdef(CONFIG_DSS     dss/dss.c)
sdk_library_sources_ifdef(CONFIG_GLS     gls/gls.c)
sdk_library_sources_ifdef(CONFIG_GLS     gls/gls_db.c)
sdk_library_sources_ifdef(CONFIG_GLS     gls/gls_racp.c)
sdk_library_sources_ifdef(CONFIG_GUS     gus/gus.c)
sdk_library_sources_ifdef(CONFIG_GUS_C   gus_c/gus_c.c)
sdk_library_sources_ifdef(CONFIG_HIDS    hids/hids.c)
sdk_library_sources_ifdef(CONFIG_HRRCPS  hrrcps/hrrcps.c)
sdk_library_sources_ifdef(CONFIG_HRS     hrs/hrs.c)
sdk_library_sources_ifdef(CONFIG_HRS_C   hrs_c/hrs_c.c)
sdk_library_sources_ifdef(CONFIG_HTS     hts/hts.c)
sdk_library_sources_ifdef(CONFIG_IAS     ias/ias.c)
sdk_library_sources_ifdef(CONFIG_IAS_C   ias_c/ias_c.c)
sdk_library_sources_ifdef(CONFIG_LLS     lls/lls.c)
sdk_library_sources_ifdef(CONFIG_LLS_C   lls_c/lls_c.c)
sdk_library_sources_ifdef(CONFIG_LMS     lms/lms.c)
sdk_library_sources_ifdef(CONFIG_LNS     lns/lns.c)
sdk_library_sources_ifdef(CONFIG_MLMR    mlmr/mlmr.c)
sdk_library_sources_ifdef(CONFIG_MLMR_C  mlmr_c/mlmr_c.c)
sdk_library_sources_ifdef(CONFIG_NDCS    ndcs/ndcs.c)
sdk_library_sources_ifdef(CONFIG_OTAS    otas/otas.c)
sdk_library_sources_ifdef(CONFIG_OTAS_C  otas_c/otas_c.c)
sdk_library_sources_ifdef(CONFIG_PASS    pass/pass.c)
sdk_library_sources_ifdef(CONFIG_PASS_C  pass_c/pass_c.c)
sdk_library_sources_ifdef(CONFIG_PCS     pcs/pcs.c)
sdk_library_sources_ifdef(CONFIG_RSCS    rscs/rscs.c)
sdk_library_sources_ifdef(CONFIG_RSCS_C  rscs_c/rscs_c.c)
sdk_library_sources_ifdef(CONFIG_RTUS    rtus/rtus.c)
sdk_library_sources_ifdef(CONFIG_SAMPLE  sample/sample.c)
sdk_library_sources_ifdef(CONFIG_THS     ths/ths.c)
sdk_library_sources_ifdef(CONFIG_THS_C   ths_c/ths_c.c)
sdk_library_sources_ifdef(CONFIG_TPS     tps/tps.c)
sdk_library_sources_ifdef(CONFIG_TPS_C   tps_c/tps_c.c)
sdk_library_sources_ifdef(CONFIG_UDS     uds/uds.c)
sdk_library_sources_ifdef(CONFIG_WSS     wss/wss.c)


target_link_libraries(sdk PUBLIC ${SDK_CURRENT_LIBRARY})

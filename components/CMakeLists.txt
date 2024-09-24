# add_subdirectory(sdk)
add_subdirectory(profiles)
add_subdirectory(libraries)
add_subdirectory(drivers_ext)
# sdk_include_directories(sdk)

application_sources_ifdef(CONFIG_BLE sdk/ble.c)

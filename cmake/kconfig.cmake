include_guard(GLOBAL)

set(KCONFIG_ROOT ${SDK_BASE}/Kconfig)
set(DOTCONFIG    ${PROJECT_BINARY_DIR}/.config)
set(AUTOCONF_H   ${PROJECT_BINARY_DIR}/include/generated/autoconf.h)
set(PARSED_KCONFIG_SOURCES_TXT ${PROJECT_BINARY_DIR}/kconfig/sources.txt)
set(APPLICATION_SOURCE_DIR ${PROJECT_SOURCE_DIR})

message(STATUS "APPLICATION_SOURCE_DIR: ${APPLICATION_SOURCE_DIR}")
message(STATUS "PROJECT_BINARY_DIR: ${PROJECT_BINARY_DIR}")
message(STATUS "PYTHON_EXECUTABLE: ${PYTHON_EXECUTABLE}")
# Create a new .config if it does not exists, or if the checksum of
# the dependencies has changed
set(merge_config_files_checksum_file ${PROJECT_BINARY_DIR}/.cmake.dotconfig.checksum)
set(CREATE_NEW_DOTCONFIG 1)
# Check if the checksum file exists too before trying to open it, though it
# should under normal circumstances
if(EXISTS ${DOTCONFIG} AND EXISTS ${merge_config_files_checksum_file})
  # Read out what the checksum was previously
  file(READ
    ${merge_config_files_checksum_file}
    merge_config_files_checksum_prev
    )
  if(
      ${merge_config_files_checksum} STREQUAL
      ${merge_config_files_checksum_prev}
      )
    # Checksum is the same as before
    set(CREATE_NEW_DOTCONFIG 0)
  endif()
endif()

find_file(FORCED_CONF_FILE prj.conf
  PATHS ${APPLICATION_SOURCE_DIR}
  NO_DEFAULT_PATH)


if(CREATE_NEW_DOTCONFIG)
  set(input_configs_flags --handwritten-input-configs)
  set(input_configs ${merge_config_files} ${FORCED_CONF_FILE})
else()
  set(input_configs ${DOTCONFIG} ${FORCED_CONF_FILE})
endif()

if(DEFINED FORCED_CONF_FILE)
  list(APPEND input_configs_flags --forced-input-configs)
endif()

execute_process(
  COMMAND ${CMAKE_COMMAND} -E env
  ${PYTHON_EXECUTABLE}
  ${SDK_BASE}/scripts/kconfig.py
  --sdk-base=${SDK_BASE}
  ${input_configs_flags}
  ${KCONFIG_ROOT}
  ${DOTCONFIG}
  ${AUTOCONF_H}
  ${PARSED_KCONFIG_SOURCES_TXT}
  ${input_configs}
  WORKING_DIRECTORY ${APPLICATION_SOURCE_DIR}
  # The working directory is set to the app dir such that the user
  # can use relative paths in CONF_FILE, e.g. CONF_FILE=nrf5.conf
  RESULT_VARIABLE ret
  )



# 读取 .config 文件
file(STRINGS "${DOTCONFIG}" CONFIG_LINES)

foreach(CONFIG_LINE ${CONFIG_LINES})
    # 去除行首尾的空白字符
    string(STRIP "${CONFIG_LINE}" CONFIG_LINE_STRIPPED)
    
    # 检查是否为注释行或空行
    if(NOT CONFIG_LINE_STRIPPED MATCHES "^#")
        # 分割键值对
        string(REGEX MATCH "^([^=]*)=[\"]?([^\"]*)[\"]?" ignore "${CONFIG_LINE_STRIPPED}")
        set(${CMAKE_MATCH_1} ${CMAKE_MATCH_2})
    endif()
endforeach()


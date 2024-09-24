
include(gcc-toolchain)
include(extensions)
include(gr5xxx-option)
include(kconfig)


application_name_set(${CONFIG_APPLICATION_NAME})

project(Sdk-Kernel LANGUAGES C ASM VERSION ${PROJECT_VERSION})
add_subdirectory(${SDK_BASE} ${__build_dir})

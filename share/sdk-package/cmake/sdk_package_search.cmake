# The purpose of this file is to provide search mechanism for locating Sdk in-work-tree package
# even when they are not installed into CMake package system
# Linux/MacOS: ~/.cmake/packages
# Windows:     Registry database

# Relative directory of workspace project dir as seen from Sdk package file
set(WORKSPACE_RELATIVE_DIR "../../../../..")

# Relative directory of Sdk dir as seen from Sdk package file
set(SDK_RELATIVE_DIR "../../../..")

# This function updates Sdk_DIR to the point to the candidate dir.
# For Sdk 3.0 and earlier, the Sdk_DIR might in some cases be
# `Sdk_DIR-NOTFOUND` or pointing to the Sdk package including the
# boilerplate code instead of the Sdk package of the included boilerplate.
# This code ensures that when Sdk releases <=3.0 is loaded, then Sdk_DIR
# will point correctly, see also #43094 which relates to this.
function(set_sdk_dir sdk_candidate)
  get_filename_component(sdk_candidate_dir "${sdk_candidate}" DIRECTORY)
  if(NOT "${sdk_candidate_dir}" STREQUAL "${Sdk_DIR}")
    set(Sdk_DIR ${sdk_candidate_dir} CACHE PATH
        "The directory containing a CMake configuration file for Sdk." FORCE
    )
  endif()
endfunction()

# This macro returns a list of parent folders to use for later searches.
macro(get_search_paths START_PATH SEARCH_PATHS PREFERENCE_LIST)
  get_filename_component(SEARCH_PATH ${START_PATH} DIRECTORY)
  while(NOT (SEARCH_PATH STREQUAL SEARCH_PATH_PREV))
    foreach(preference ${PREFERENCE_LIST})
      list(APPEND SEARCH_PATHS ${SEARCH_PATH}/${preference})
    endforeach()
    list(APPEND SEARCH_PATHS ${SEARCH_PATH}/sdk)
    list(APPEND SEARCH_PATHS ${SEARCH_PATH})
    set(SEARCH_PATH_PREV ${SEARCH_PATH})
    get_filename_component(SEARCH_PATH ${SEARCH_PATH} DIRECTORY)
  endwhile()
endmacro()

# This macro can check for additional Sdk package that has a better match
# Options:
# - SDK_BASE                : Use the specified SDK_BASE directly.
# - WORKSPACE_DIR              : Search for projects in specified  workspace.
# - SEARCH_PARENTS             : Search parent folder of current source file (application)
#                                to locate in-project-tree Sdk candidates.
# - CHECK_ONLY                 : Only set PACKAGE_VERSION_COMPATIBLE to false if a better candidate
#                                is found, default is to also include the found candidate.
# - VERSION_CHECK              : This is the version check stage by CMake find package
# - CANDIDATES_PREFERENCE_LIST : List of candidate to be preferred, if installed
macro(check_sdk_package)
  set(options CHECK_ONLY SEARCH_PARENTS VERSION_CHECK)
  set(single_args WORKSPACE_DIR SDK_BASE)
  set(list_args CANDIDATES_PREFERENCE_LIST)
  cmake_parse_arguments(CHECK_SDK_PACKAGE "${options}" "${single_args}" "${list_args}" ${ARGN})

  if(CHECK_SDK_PACKAGE_SDK_BASE)
    set(SEARCH_SETTINGS PATHS ${CHECK_SDK_PACKAGE_SDK_BASE} NO_DEFAULT_PATH)
  endif()

  if(CHECK_SDK_PACKAGE_WORKSPACE_DIR)
    set(SEARCH_SETTINGS PATHS ${CHECK_SDK_PACKAGE_WORKSPACE_DIR}/sdk ${CHECK_SDK_PACKAGE_WORKSPACE_DIR} NO_DEFAULT_PATH)
  endif()

  if(CHECK_SDK_PACKAGE_SEARCH_PARENTS)
    get_search_paths(${CMAKE_CURRENT_SOURCE_DIR} SEARCH_PATHS "${CHECK_SDK_PACKAGE_CANDIDATES_PREFERENCE_LIST}")
    set(SEARCH_SETTINGS PATHS ${SEARCH_PATHS} NO_DEFAULT_PATH)
  endif()

  # Searching for version zero means there will be no match, but we obtain
  # a list of all potential Sdk candidates in the tree to consider.
  find_package(Sdk 0.0.0 EXACT QUIET ${SEARCH_SETTINGS})

  # The find package will also find ourself when searching using installed candidates.
  # So avoid re-including unless NO_DEFAULT_PATH is set.
  # NO_DEFAULT_PATH means explicit search and we could be part of a preference list.
  if(NOT (NO_DEFAULT_PATH IN_LIST SEARCH_SETTINGS))
    list(REMOVE_ITEM Sdk_CONSIDERED_CONFIGS ${CMAKE_CURRENT_LIST_DIR}/SdkConfig.cmake)
  endif()
  list(REMOVE_DUPLICATES Sdk_CONSIDERED_CONFIGS)

  foreach(SDK_CANDIDATE ${Sdk_CONSIDERED_CONFIGS})
    if(CHECK_SDK_PACKAGE_WORKSPACE_DIR)
      # Check is done in Sdk workspace already, thus check only for pure Sdk candidates.
      get_filename_component(CANDIDATE_DIR ${SDK_CANDIDATE}/${SDK_RELATIVE_DIR} ABSOLUTE)
    else()
      get_filename_component(CANDIDATE_DIR ${SDK_CANDIDATE}/${WORKSPACE_RELATIVE_DIR} ABSOLUTE)
    endif()

    if(CHECK_SDK_PACKAGE_SDK_BASE)
        if(CHECK_SDK_PACKAGE_VERSION_CHECK)
          string(REGEX REPLACE "\.cmake$" "Version.cmake" SDK_VERSION_CANDIDATE ${SDK_CANDIDATE})
          include(${SDK_VERSION_CANDIDATE} NO_POLICY_SCOPE)
          return()
        else()
          include(${SDK_CANDIDATE} NO_POLICY_SCOPE)
          set_sdk_dir(${SDK_CANDIDATE})
          return()
        endif()
    endif()

    string(FIND "${CMAKE_CURRENT_SOURCE_DIR}" "${CANDIDATE_DIR}/" COMMON_INDEX)
    if (COMMON_INDEX EQUAL 0)
      if(CHECK_SDK_PACKAGE_CHECK_ONLY)
        # A better candidate exists, thus return
        set(PACKAGE_VERSION_COMPATIBLE FALSE)
        return()
      elseif(SDK_CANDIDATE STREQUAL ${CMAKE_CURRENT_LIST_DIR}/SdkConfig.cmake)
        # Current Sdk is preferred one, let's just break the loop and continue processing.
        break()
      else()
        if(CHECK_SDK_PACKAGE_VERSION_CHECK)
          string(REGEX REPLACE "\.cmake$" "Version.cmake" SDK_VERSION_CANDIDATE ${SDK_CANDIDATE})
          include(${SDK_VERSION_CANDIDATE} NO_POLICY_SCOPE)
          return()
	else()
          include(${SDK_CANDIDATE} NO_POLICY_SCOPE)
          set_sdk_dir(${SDK_CANDIDATE})
	  return()
        endif()
      endif()
    endif()
  endforeach()
endmacro()

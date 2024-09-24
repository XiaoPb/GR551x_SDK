# SPDX-License-Identifier: Apache-2.0

# This file provides Sdk Config Package functionality.
#
# The purpose of this files is to allow users to decide if they want to:
# - Use SDK_BASE environment setting for explicitly set select a sdk installation
# - Support automatic Sdk installation lookup through the use of find_package(SDK)

# First check to see if user has provided a Sdk base manually.
# Set Sdk base to environment setting.
# It will be empty if not set in environment.

# Internal Sdk CMake package message macro.
#
# This macro is only intended to be used within the Sdk CMake package.
# The function `find_package()` supports an optional QUIET argument, and to
# honor that argument, the package_message() macro will not print messages when
# said flag has been given.
#
# Arguments to sdk_package_message() are identical to regular CMake message()
# function.
macro(sdk_package_message)
  if(NOT Sdk_FIND_QUIETLY)
    message(${ARGN})
  endif()
endmacro()

macro(include_boilerplate location)
  set(Sdk_DIR ${SDK_BASE}/share/sdk-package/cmake CACHE PATH
      "The directory containing a CMake configuration file for Sdk." FORCE
  )
  list(PREPEND CMAKE_MODULE_PATH ${SDK_BASE}/cmake)
  if(SDK_UNITTEST)
    sdk_package_message(DEPRECATION "The SdkUnittest CMake package has been deprecated.\n"
                           "SdkUnittest has been replaced with Sdk CMake module 'unittest' \n"
                           "and can be loaded as: 'find_package(Sdk COMPONENTS unittest)'"
    )
    set(SdkUnittest_FOUND True)
    set(Sdk_FIND_COMPONENTS unittest)
  else()
    set(Sdk_FOUND True)
  endif()

  if(NOT DEFINED APPLICATION_SOURCE_DIR)
    set(APPLICATION_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR} CACHE PATH
        "Application Source Directory"
    )
  endif()

  if(NOT DEFINED APPLICATION_BINARY_DIR)
    set(APPLICATION_BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR} CACHE PATH
        "Application Binary Directory"
    )
  endif()

  set(__build_dir ${APPLICATION_BINARY_DIR}/sdk)
  set(PROJECT_BINARY_DIR ${__build_dir})

  if(NOT NO_BOILERPLATE)
    list(LENGTH Sdk_FIND_COMPONENTS components_length)
    # The module messages are intentionally higher than STATUS to avoid the -- prefix
    # and make them more visible to users. This does result in them being output
    # to stderr, but that is an implementation detail of cmake.
    if(components_length EQUAL 0)
      sdk_package_message(NOTICE "Loading Sdk default modules (${location}).")
      include(sdk_default NO_POLICY_SCOPE)
    else()
      string(JOIN " " msg_components ${Sdk_FIND_COMPONENTS})
      sdk_package_message(NOTICE "Loading Sdk module(s) (${location}): ${msg_components}")
      foreach(component ${Sdk_FIND_COMPONENTS})
        if(${component} MATCHES "^\([^:]*\):\(.*\)$")
          string(REPLACE "," ";" SUB_COMPONENTS ${CMAKE_MATCH_2})
          set(component ${CMAKE_MATCH_1})
        endif()
        include(${component})
      endforeach()
    endif()
  else()
    sdk_package_message(DEPRECATION "The NO_BOILERPLATE setting has been deprecated.\n"
                           "Please use: 'find_package(Sdk COMPONENTS <components>)'"
    )
  endif()
endmacro()

set(ENV_SDK_BASE $ENV{SDK_BASE})
if((NOT DEFINED SDK_BASE) AND (DEFINED ENV_SDK_BASE))
  # Get rid of any double folder string before comparison, as example, user provides
  # SDK_BASE=//path/to//sdk_base/
  # must also work.
  get_filename_component(SDK_BASE ${ENV_SDK_BASE} ABSOLUTE)
  set(SDK_BASE ${SDK_BASE} CACHE PATH "Sdk base")
  include_boilerplate("Sdk base")
  return()
endif()

if (DEFINED SDK_BASE)
  include_boilerplate("Sdk base (cached)")
  return()
endif()

# If SDK_CANDIDATE is set, it means this file was include instead of called via find_package directly.
if(SDK_CANDIDATE)
  set(IS_INCLUDED TRUE)
else()
  include(${CMAKE_CURRENT_LIST_DIR}/sdk_package_search.cmake)
endif()

# Find out the current Sdk base.
get_filename_component(CURRENT_SDK_DIR ${CMAKE_CURRENT_LIST_FILE}/${SDK_RELATIVE_DIR} ABSOLUTE)
get_filename_component(CURRENT_WORKSPACE_DIR ${CMAKE_CURRENT_LIST_FILE}/${WORKSPACE_RELATIVE_DIR} ABSOLUTE)

string(FIND "${CMAKE_CURRENT_SOURCE_DIR}" "${CURRENT_SDK_DIR}/" COMMON_INDEX)
if (COMMON_INDEX EQUAL 0)
  # Project is in Sdk repository.
  # We are in Sdk repository.
  set(SDK_BASE ${CURRENT_SDK_DIR} CACHE PATH "Sdk base")
  include_boilerplate("Sdk repository")
  return()
endif()

if(IS_INCLUDED)
  # A higher level did the checking and included us and as we are not in Sdk repository
  # (checked above) then we must be in Sdk workspace.
  set(SDK_BASE ${CURRENT_SDK_DIR} CACHE PATH "Sdk base")
  include_boilerplate("Sdk workspace")
endif()

if(NOT IS_INCLUDED)
  string(FIND "${CMAKE_CURRENT_SOURCE_DIR}" "${CURRENT_WORKSPACE_DIR}/" COMMON_INDEX)
  if (COMMON_INDEX EQUAL 0)
    # Project is in Sdk workspace.
    # This means this Sdk is likely the correct one, but there could be an alternative installed along-side
    # Thus, check if there is an even better candidate.
    # This check works the following way.
    # CMake finds packages will look all packages registered in the user package registry.
    # As this code is processed inside registered packages, we simply test if another package has a
    # common path with the current sample.
    # and if so, we will return here, and let CMake call into the other registered package for real
    # version checking.
    check_sdk_package(WORKSPACE_DIR ${CURRENT_WORKSPACE_DIR})

    if(SDK_PREFER)
      check_sdk_package(SEARCH_PARENTS CANDIDATES_PREFERENCE_LIST ${SDK_PREFER})
    endif()

    # We are the best candidate, so let's include boiler plate.
    set(SDK_BASE ${CURRENT_SDK_DIR} CACHE PATH "Sdk base")
    include_boilerplate("Sdk workspace")
    return()
  endif()

  check_sdk_package(SEARCH_PARENTS CANDIDATES_PREFERENCE_LIST ${SDK_PREFER})

  # Ending here means there were no candidates in workspace of the app.
  # Thus, the app is built as a Sdk Freestanding application.
  # CMake find_package has already done the version checking, so let's just include boiler plate.
  # Previous find_package would have cleared Sdk_FOUND variable, thus set it again.
  set(SDK_BASE ${CURRENT_SDK_DIR} CACHE PATH "Sdk base")
  include_boilerplate("Freestanding")
endif()

# Needed for CMAKE_MSVC_RUNTIME_LIBRARY
cmake_minimum_required(VERSION 3.15)

# Hunter package configuration
include("cmake/HunterGate.cmake")
HunterGate(
    URL "https://github.com/cpp-pm/hunter/archive/v0.23.224.tar.gz"
    SHA1 "18e57a43efc435f2e1dae1291e82e42afbf940be"
    LOCAL
    #FILEPATH "${CMAKE_CURRENT_LIST_DIR}/cmake/Hunter/config.cmake"
)
#include(cmake/HunterPackages.cmake)

project(LLVMCMakeTemplate)

hunter_add_package(LLVM)

# Enable solution folder support
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# Require c++17
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# LLVM wrapper
include(cmake/LLVM.cmake)

# MSVC-specific options
if(MSVC)
    # TODO: This assumes the installed LLVM was built in Release mode
    # TODO: this is not very friendly cmake, probably this should respect the cache and not override the user's choice
    set(CMAKE_C_FLAGS_DEBUG "/ZI /Od /Ob0 /DNDEBUG" CACHE STRING "" FORCE)
    set(CMAKE_CXX_FLAGS_DEBUG "/ZI /Od /Ob0 /DNDEBUG" CACHE STRING "" FORCE)

    if(${LLVM_USE_CRT_RELEASE} STREQUAL "MD")
        set(CMAKE_MSVC_RUNTIME_LIBRARY MultiThreadedDLL)
    elseif(${LLVM_USE_CRT_RELEASE} STREQUAL "MT")
        set(CMAKE_MSVC_RUNTIME_LIBRARY MultiThreaded)
    else()
        message(FATAL_ERROR "Unsupported LLVM_USE_CRT_RELEASE=${LLVM_USE_CRT_RELEASE}")
    endif()
endif()

add_executable(${PROJECT_NAME}
    src/example.cpp
)
target_link_libraries(${PROJECT_NAME} PRIVATE
    LLVM
)

# Set the main project as the startup project
set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${PROJECT_NAME})
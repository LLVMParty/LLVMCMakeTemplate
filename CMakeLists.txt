# Needed for CMAKE_MSVC_RUNTIME_LIBRARY
cmake_minimum_required(VERSION 3.15)
cmake_policy(SET CMP0091 NEW)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
    message(FATAL_ERROR "In-tree builds are not supported. Run CMake from a separate directory: cmake -B build")
endif()

# Hunter package configuration
option(HUNTER_ENABLED "Enable the hunter package manager to automatically download and compile LLVM" OFF)
if(HUNTER_ENABLED)
    include(cmake/HunterPackages.cmake)
endif()

project(LLVMCMakeTemplate)

# Enable solution folder support
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# Require c++17
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

find_package(LLVM-Wrapper REQUIRED)

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

add_executable(example
    src/example.cpp
)
target_link_libraries(example PRIVATE
    LLVM-Wrapper
)
target_compile_features(example PRIVATE
    cxx_std_20
)

# Set the main project as the startup project
set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT example)

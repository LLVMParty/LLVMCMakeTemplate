# This is an INTERFACE target for LLVM, usage:
#   target_link_libraries(${PROJECT_NAME} <PRIVATE|PUBLIC|INTERFACE> LLVM-Wrapper)
# The include directories and compile definitions will be properly handled.

set(CMAKE_FOLDER_LLVM "${CMAKE_FOLDER}")
if(CMAKE_FOLDER)
    set(CMAKE_FOLDER "${CMAKE_FOLDER}/LLVM")
else()
    set(CMAKE_FOLDER "LLVM")
endif()

# Find LLVM
find_package(LLVM REQUIRED CONFIG)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

# Split the definitions properly (https://weliveindetail.github.io/blog/post/2017/07/17/notes-setup.html)
separate_arguments(LLVM_DEFINITIONS)

# Some diagnostics (https://stackoverflow.com/a/17666004/1806760)
message(STATUS "LLVM libraries: ${LLVM_LIBRARIES}")
message(STATUS "LLVM includes: ${LLVM_INCLUDE_DIRS}")
message(STATUS "LLVM definitions: ${LLVM_DEFINITIONS}")
message(STATUS "LLVM tools: ${LLVM_TOOLS_BINARY_DIR}")

add_library(LLVM-Wrapper INTERFACE)
target_include_directories(LLVM-Wrapper SYSTEM INTERFACE ${LLVM_INCLUDE_DIRS})
target_compile_definitions(LLVM-Wrapper INTERFACE ${LLVM_DEFINITIONS})

if(WIN32)
    target_compile_definitions(LLVM-Wrapper INTERFACE NOMINMAX)
endif()

# https://github.com/JonathanSalwan/Triton/issues/1082#issuecomment-1030826696
if(LLVM_LINK_LLVM_DYLIB)
    target_link_libraries(LLVM-Wrapper INTERFACE LLVM)
else()
    target_link_libraries(LLVM-Wrapper INTERFACE ${LLVM_AVAILABLE_LIBS})
endif()

set(CMAKE_FOLDER "${CMAKE_FOLDER_LLVM}")
unset(CMAKE_FOLDER_LLVM)

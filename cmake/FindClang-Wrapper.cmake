# This is an INTERFACE target for LLVM, usage:
#   target_link_libraries(${PROJECT_NAME} <PRIVATE|PUBLIC|INTERFACE> LLVM-Wrapper)
# The include directories and compile definitions will be properly handled.

set(CMAKE_FOLDER_LLVM "${CMAKE_FOLDER}")
if(CMAKE_FOLDER)
    set(CMAKE_FOLDER "${CMAKE_FOLDER}/LLVM")
else()
    set(CMAKE_FOLDER "LLVM")
endif()

# Find Clang
find_package(Clang REQUIRED CONFIG)
set(CLANG_LIBRARIES "clangBasic;clangLex;clangParse;clangAST;clangDynamicASTMatchers;clangASTMatchers;clangCrossTU;clangSema;clangCodeGen;clangAnalysis;clangEdit;clangRewrite;clangARCMigrate;clangDriver;clangSerialization;clangRewriteFrontend;clangFrontend;clangFrontendTool;clangToolingCore;clangToolingInclusions;clangToolingRefactoring;clangToolingASTDiff;clangToolingSyntax;clangDependencyScanning;clangTransformer;clangTooling;clangDirectoryWatcher;clangIndex;clangStaticAnalyzerCore;clangStaticAnalyzerCheckers;clangStaticAnalyzerFrontend;clangFormat;clangTesting;clangHandleCXX;clangHandleLLVM;libclang")

message(STATUS "Using ClangConfig.cmake in: ${CLANG_CMAKE_DIR}")
message(STATUS "Clang libraries: ${CLANG_LIBRARIES}")
message(STATUS "Clang includes: ${CLANG_INCLUDE_DIRS}")

add_library(Clang-Wrapper INTERFACE)
target_include_directories(Clang-Wrapper SYSTEM INTERFACE ${CLANG_INCLUDE_DIRS})

# For LLVM: https://github.com/JonathanSalwan/Triton/issues/1082#issuecomment-1030826696
# This variable also exists for Clang, but I don't know what the target is called
if(CLANG_LINK_LLVM_DYLIB)
    message(FATAL_ERROR "Untested scenario, remove this and see if it works")
    target_link_libraries(Clang-Wrapper INTERFACE Clang)
else()
    target_link_libraries(Clang-Wrapper INTERFACE ${CLANG_LIBRARIES})
endif()

set(CMAKE_FOLDER "${CMAKE_FOLDER_LLVM}")
unset(CMAKE_FOLDER_LLVM)

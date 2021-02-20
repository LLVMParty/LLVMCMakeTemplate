#message(FATAL_ERROR "Hunter config")

hunter_config(
    LLVM
    VERSION "11.0.1"
    URL "https://github.com/llvm/llvm-project/archive/llvmorg-11.0.1.tar.gz"
    SHA1 "99290C28654EFE520247B7859ED45CF7BC895641"
    CMAKE_ARGS
        LLVM_ENABLE_CRASH_OVERRIDES=OFF
        LLVM_ENABLE_ASSERTIONS=ON
        LLVM_ENABLE_PROJECTS=clang;lld
        LLVM_INCLUDE_EXAMPLES=OFF
        LLVM_INCLUDE_TESTS=OFF
        LLVM_INCLUDE_DOCS=OFF
        # On MSVC LLVM adds /MP per default. The default value for HUNTER_JOBS_NUMBER also adds /maxcpucount:N which when combined cause N*N threads
        LLVM_COMPILER_JOBS=1
    CONFIGURATION_TYPES Release
    
)
# TODO: somehow make this work
hunter_source_subdir(LLVM SOURCE_SUBDIR llvm)
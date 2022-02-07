# Set up Hunter
set(HUNTER_URL "https://github.com/LLVMParty/hunter/archive/ac772212b1da5bec948768feda299e2055486876.zip")
set(HUNTER_SHA1 "9A8F3597943B56AE4C9C325FB90D85C161A3EB8F")

set(HUNTER_LLVM_VERSION 13.0.1)
set(HUNTER_LLVM_CMAKE_ARGS
    LLVM_ENABLE_CRASH_OVERRIDES=OFF
    LLVM_ENABLE_ASSERTIONS=ON
    LLVM_ENABLE_PROJECTS=clang;lld
)
set(HUNTER_PACKAGES LLVM)

include(FetchContent)
message(STATUS "Fetching hunter...")
FetchContent_Declare(SetupHunter GIT_REPOSITORY https://github.com/cpp-pm/gate)
FetchContent_MakeAvailable(SetupHunter)
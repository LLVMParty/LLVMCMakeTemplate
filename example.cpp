#include <llvm/IR/Module.h>
#include <llvm/IR/AssemblyAnnotationWriter.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/Bitcode/BitcodeReader.h>
#include <llvm/Support/SourceMgr.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/Support/FormattedStream.h>

#include <iostream>
#include <fstream>

static std::unique_ptr<llvm::Module> load_module(llvm::LLVMContext& context, const std::string& bitcode)
{
    llvm::SMDiagnostic error;
    llvm::StringRef sr(bitcode.data(), bitcode.size());
    auto buf = llvm::MemoryBuffer::getMemBuffer(sr, "", false);
    auto module = parseIR(*buf, error, context);

    if (!module)
    {
        std::string what;
        llvm::raw_string_ostream os(what);
        error.print("error after parseIR()", os);
        std::cerr << what;
    }

    return module;
}

int main(int argc, char* argv[])
{
    if (argc < 2)
    {
        std::cerr << "Usage: LLVMCMakeTemplate file.bc\n";
        return EXIT_FAILURE;
    }

    std::ifstream stream(argv[1], std::ios_base::binary);
    if (!stream.is_open())
    {
        std::cerr << "Failed to load " << argv[1] << '\n';
        return EXIT_FAILURE;
    }
    std::string bitcode((std::istreambuf_iterator<char>(stream)), (std::istreambuf_iterator<char>()));

    llvm::LLVMContext context;
    auto module = load_module(context, bitcode);
    if (module)
        module->dump();

    return EXIT_SUCCESS;
}
return {
    cmd = {
        'clangd',
        '--clang-tidy',
        -- '--log=verbose',
        '--background-index',
        '--compile-commands-dir=build',
        '--query-driver=/nix/store/*-gcc-*/bin/gcc,/nix/store/*-gcc-*/bin/g++,/nix/store/*-clang-*/bin/clang,/nix/store/*-clang-*/bin/clang++',
    },
    filetypes = {
        'c',
        'cpp',
        'objc',
        'objcpp',
        'cuda',
    },
    root_markers =   { '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', 'configure.ac', '.git' },
    settings = {
    },
}

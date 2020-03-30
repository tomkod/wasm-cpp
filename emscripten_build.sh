source emscripten_base.inc

say ''
say '****************'
say '*** Building ***'
say '****************'

cd "$EMSDK_ROOT"

# Build in release mode to not run out of memory
# https://github.com/kripken/emscripten/issues/4667

say '* Emscripten: setup'; {
    ./emsdk update
    ./emsdk install $EMSCRIPT_RELEASE --build=Release
    ./emsdk activate $EMSCRIPT_RELEASE

    # Use incoming because of https://github.com/kripken/emscripten/pull/5239
    # ./emsdk install emscripten-incoming-32bit --build=Release
    # ./emsdk activate emscripten-incoming-32bit

    # Needed by emcc
    sed -i "s/NODE_JS *= *'\(.*\)'/NODE_JS=['\1','--stack_size=8192']/" ~/.emscripten

    # Regenerate emsdk_set_env.sh
    ./emsdk construct_env ""
}

# Don't source emsdk_env directly, as it produces output that can't be logged
# without creating a subshell (which would break `source`)
source "${EMSDK_ROOT}emsdk_set_env.sh"

# emcc fails in all sorts of weird ways without this
ulimit -s unlimited

say '* Emscripten: stdlib (very slow!)'; {
    mkdir -p "$EMSCRIPTEN_TEMPDIR"
    cd "$EMSCRIPTEN_TEMPDIR"
    printf '#include<stdio.h>\nint main() { return 0; }\n' > minimal.c
    emcc minimal.c
}


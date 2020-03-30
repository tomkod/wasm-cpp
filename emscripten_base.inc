export BASEDIR="$(pwd)/"
export EMSCRIPTEN_BUILDDIR="${BASEDIR}external/"
export EMSCRIPTEN_TEMPDIR="/tmp/emscripten/"
export EMSCRIPT_RELEASE="1.39.7"
export EMSDK_ROOT="${EMSCRIPTEN_BUILDDIR}emscripten-$EMSCRIPT_RELEASE/"

function say() {
    printf "\033[1;32m%s\033[0m\n" "$1"
}


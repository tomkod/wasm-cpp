if [ -z ${BASEDIR+x} ]; then
    echo "BASEDIR must be defined"
    exit
fi

source "${BASEDIR}emscripten_base.inc"

# Don't source emsdk_env directly, as it produces output that can't be logged
# without creating a subshell (which would break `source`)
source "${EMSDK_ROOT}emsdk_set_env.sh"

# emcc fails in all sorts of weird ways without this
ulimit -s unlimited


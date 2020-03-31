export PROJDIR="$(pwd)/"
export BASEDIR="$(pwd)/../"
source "${BASEDIR}emscripten_setup.inc"

export BUILDDIR="${PROJDIR}build_wasm/"
export DEPLOYDIR="${PROJDIR}deploy/"
export BUILDFILE="fib_test"

function say() {
    printf "\033[0;33m%s\033[0m\n" "$1"
}

function say_run() {
	say "$1"
	$1
}

# Shared options
EMCC_SHARED_OPTIONS=(
    -s INVOKE_RUN=0 # Don't call main automatically
    # -O${OPTLEVEL}

    # Don't pollute the global namespace
    -s MODULARIZE=1

    # Catch errors early
    -s STRICT=1 -s ERROR_ON_UNDEFINED_SYMBOLS=1

    # Avoid various aborts
    # -s OUTLINING_LIMIT=10000 # Avoid “excessive recursion” errors at asm.js parsing time
    #                          # (But beware: excessively low values cause stack overflows in the program itself)
    -s DISABLE_EXCEPTION_CATCHING=0 # Let program catch exceptions
    -s ABORTING_MALLOC=0 -s ALLOW_MEMORY_GROWTH=1 # Allow dynamic memory resizing
)

EMCC_OPTIONS=(
    ${EMCC_SHARED_OPTIONS[@]}

    -s ENVIRONMENT='worker'

    -s EXPORT_NAME="'WASM_MODULE'"

	-s EXPORTED_FUNCTIONS='["_main"]'
    -s 'EXTRA_EXPORTED_RUNTIME_METHODS=["FS","callMain"]'

    # Enable this to exit fully after main completes
    # https://github.com/kripken/emscripten/commit/f585dcbc2d929ef8b8bc6813e0710ec3215ac0b1
    # -s NO_EXIT_RUNTIME=0

    # Add this to make it possible to run the test suite (it's
    # normally included by default, but “-s STRICT=1” disables it)
    -l "nodefs.js"
)

EMCC_WASM_OPTIONS=(
    #-s USE_PTHREADS=1
    #-s WASM_MEM_MAX=100MB
    -s WASM=1
    # Async compilation causes Firefox to infloop, repeatedly printing “still
    # waiting on run dependencies: dependency: wasm-instantiate”. We'll run
    # in a WebWorker anyway, so it wouldn't buy us much.
    -s WASM_ASYNC_COMPILATION=0
)

mkdir -p ${BUILDDIR}
cd ${BUILDDIR}

emconfigure cmake ..
emmake make -j6
emcc "${EMCC_OPTIONS[@]}" "${EMCC_WASM_OPTIONS[@]}" ./lib${BUILDFILE}.a -o ${BUILDFILE}.js

cd ..

mkdir -p ${DEPLOYDIR}
say_run "cp run_test.html ${DEPLOYDIR}"
say_run "cp run_test.js ${DEPLOYDIR}"
say_run "cp worker.js ${DEPLOYDIR}"
say_run "cp ${BUILDDIR}${BUILDFILE}.js ${DEPLOYDIR}"
say_run "cp ${BUILDDIR}${BUILDFILE}.wasm ${DEPLOYDIR}"

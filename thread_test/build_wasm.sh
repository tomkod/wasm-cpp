# Check if "source emscripten_setup" was called before
# and environment variables are set
: ${EMSDK_ROOT:?EMSDK_ROOT is not set: call source emscripten_setup}

export BUILDDIR=build_wasm
export DEPLOYDIR=deploy

function say() {
    printf "\033[0;33m%s\033[0m\n" "$1"
}

function say_run() {
	say "$1"
	$1
}

mkdir -p ${BUILDDIR}
cd ${BUILDDIR}

emconfigure cmake ..
emmake make -j6

cd ..

mkdir -p ${DEPLOYDIR}
say_run "cp ./run_test.html ${DEPLOYDIR}/"
say_run "cp ${BUILDDIR}/run_test.js ${DEPLOYDIR}/"
say_run "cp ${BUILDDIR}/run_test.wasm ${DEPLOYDIR}/"
say_run "cp ${BUILDDIR}/run_test.worker.js ${DEPLOYDIR}/"

export PROJDIR="$(pwd)/"
export BASEDIR="$(pwd)/../"
source "${BASEDIR}emscripten_setup.inc"

export BUILDDIR="${PROJDIR}build_wasm/"
export DEPLOYDIR="${PROJDIR}deploy/"

function say() {
    printf "\033[0;33m%s\033[0m\n" "$1"
}

function say_run() {
	say "$1"
	$1
}

mkdir -p ${BUILDDIR}
cd ${BUILDDIR}

emconfigure cmake ${PROJDIR}
emmake make -j6

cd ${PROJDIR}

mkdir -p ${DEPLOYDIR}
say_run "cp ./run_test.html ${DEPLOYDIR}"
say_run "cp ${BUILDDIR}run_test.js ${DEPLOYDIR}"
say_run "cp ${BUILDDIR}run_test.wasm ${DEPLOYDIR}"
say_run "cp ${BUILDDIR}run_test.worker.js ${DEPLOYDIR}"

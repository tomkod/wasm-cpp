# Simple C++ to WASM example

**author:** Tom

**update:** 2020.03.30

## Downloading and building emscripten

The following scripts will download and build emscripten:

    ./emscripten_download.sh
    ./emscripten_build.sh

## Compiling example

    source emscripten_setup
    cd fib_test
    ./build_wasm.sh

## Running example

Start HTTP server from deploy folder:

    cd fib_test/deploy
    python3 -m http.server

In the browser, open:

    http://localhost:8000/run_test.html

If everything goes well, open the browser console
and you should see (among other messages):

    [wasm.stdout] 377

## Compiling (in general)

Initialize environment variables

    source emscripten_setup

Go to your build folder.

If you use cmake:

    emconfigure cmake

otherwise, if you use configure:

    emconfigure ./configure

Run make:

    emmake make -j6

If executable is produced, .js and .wasm are created automatically,
otherwise you need to provide object/lib files:

    emcc <options> <object/library .o or .a> -o <output file>.js

(see fib_test/build_wasm.sh for example options)

FIXME: how to feed emcc options directly to emmake ?


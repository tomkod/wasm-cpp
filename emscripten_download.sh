source emscripten_base.inc

say ''
say '*******************'
say '*** Downloading ***'
say '*******************'

rm -rf "$EMSCRIPTEN_BUILDDIR"
mkdir "$EMSCRIPTEN_BUILDDIR"
git clone --depth 1 https://github.com/emscripten-core/emsdk.git "$EMSDK_ROOT"



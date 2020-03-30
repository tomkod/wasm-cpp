function makeWorker(self, console) {
    var prog = null;
    var ready = false;

    function postMessage(kind, payload) {
        self.postMessage({ kind: '['+kind+']', payload: payload });
    }

    function onRuntimeInitialized() {
        postMessage("stdout", "runtime initialized");
        ready = true;
    }

    function run() {
        postMessage("stdout", "Running...");
        if (!ready) {
			postMessage("stderr", "prog is not ready");
			return;
		}
		if (!prog) {
			postMessage("stderr", "prog is null");
			return;
		}
	    prog.callMain(['13']);
    }

    function onMessage(event) {
        console.info("Window → Worker:");
        var kind = event.data.kind;
        var payload = event.data.payload;
        if (kind == '[cmd]') {
            switch(payload) {
                case 'run':
                    run();
                    break;
            }
        }
        console.log(kind, payload);
    }

    function init() {
        console.log("Downloading...");
        self.importScripts("fib_test.js");

        console.log("Initializing...");
        prog = fib_test({
            onRuntimeInitialized: onRuntimeInitialized,
            print: function(message) { postMessage("wasm.stdout", message); },
            printErr: function(message) { postMessage("wasm.stderr", message); }
        });
        self.onmessage = onMessage;
    }

    return { init: init };
}

makeWorker(self, console).init();


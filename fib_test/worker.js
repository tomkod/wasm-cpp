function makeWorker(self, console) {
    var prog = null;
    var ready = false;

    function postMessage(channel, message) {
        self.postMessage({ channel: '['+channel+']', message: message });
    }

    function onRuntimeInitialized() {
        postMessage("stdout", "runtime initialized");
        ready = true;
    }

    function run(args) {
        postMessage("stdout", "Running...");
        if (!ready) {
			postMessage("stderr", "prog is not ready");
			return;
		}
		if (!prog) {
			postMessage("stderr", "prog is null");
			return;
		}
	    prog.callMain(args);
    }

    function onMessage(event) {
        console.info("Window → Worker:");
        var cmd = event.data.cmd;
        var args = event.data.args;
        switch(cmd) {
            case 'run':
                run(args);
                break;
            default:
                postMessage("stderr", "unknown command " + args);
        }
    }

    function init() {
        console.log("Downloading...");
        self.importScripts("fib_test.js");

        console.log("Initializing...");
        prog = WASM_MODULE({
            onRuntimeInitialized: onRuntimeInitialized,
            print: function(message) { postMessage("wasm.stdout", message); },
            printErr: function(message) { postMessage("wasm.stderr", message); }
        });
        self.onmessage = onMessage;
    }

    return { init: init };
}

makeWorker(self, console).init();


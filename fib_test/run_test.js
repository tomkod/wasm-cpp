function runTest() {
	var worker;

    function postMessage(kind, payload) {
        worker.postMessage({ kind: '['+kind+']', payload: payload });
    }

	function onMessage(event) {
        console.info("Worker → Window:");
        var kind = event.data.kind;
        var payload = event.data.payload;
        console.log(kind, payload);
    }

    function setupWorker() {
        worker = new window.Worker("worker.js");
		worker.onmessage = onMessage;
		postMessage("cmd", "run");
    }

    setupWorker();
}


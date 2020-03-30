function runTest(args) {
	var worker;

	function onMessage(event) {
        console.info("Worker → Window:");
        var channel = event.data.channel;
        var message = event.data.message;
        console.log(channel, message);
    }

    function setupWorker(args) {
        worker = new window.Worker("worker.js");
		worker.onmessage = onMessage;
		worker.postMessage({cmd: 'run', args: args});
    }

    setupWorker(args);
}


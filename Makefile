default: server

bin-dir:
	mkdir -p bin

event: bin-dir
	nitc -o bin/event lib/event/event.nit

request: bin-dir
	nitc -o bin/request src/http/request.nit

file_server: bin-dir
	nitc -o bin/file_server -I lib/ examples/nitcorn_file_server.nit

app: bin-dir
	nitc -o bin/app -I lib/ examples/nitcorn_app

hello_world: bin-dir
	nitc -o bin/hello_world -I lib/ examples/nitcorn_hello_world.nit

clean:
	rm -rf bin/*

default: server

bin-dir:
	mkdir -p bin

event: bin-dir
	nitc -o bin/event lib/event/event.nit

request: bin-dir
	nitc -o bin/request src/http/request.nit

server: bin-dir
	nitc -o bin/server -I lib/ -I src/http/ -I src/config/ src/server.nit

app: bin-dir
	nitc -o bin/app -I lib/ -I src/http/ -I src/config/ -I src/ -I src/example-app -I src/example-app/actions src/example-app/app.nit

clean:
	rm -rf bin/*

default: server

bin-dir:
	mkdir -p bin

event: bin-dir
	nitc -o bin/event lib/event/event.nit

request: bin-dir
	nitc -o bin/request src/http/request.nit

server: bin-dir
	nitc -o bin/server -I lib/ -I src/http/ src/server.nit

clean:
	rm -rf bin/*

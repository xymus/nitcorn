default: server

bin-dir:
	mkdir -p bin

event: bin-dir
	nitc -o bin/event lib/event/event.nit

server: bin-dir
	nitc -o bin/server -I lib/ src/server.nit

clean:
	rm -rf bin/*

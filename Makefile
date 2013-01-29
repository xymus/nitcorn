default: server

bin-dir:
	mkdir -p bin/lib/

event: bin-dir
	nitc -o bin/lib/event lib/event/event.nit

server: bin-dir event
	nitc src/server.nit -o bin/server -I lib

clean:
	rm -rf bin/*
	mkdir bin/lib/

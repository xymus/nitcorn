<<<<<<< Updated upstream
default: server

bin-dir:
	mkdir -p bin

event: bin-dir
	nitc -o bin/event lib/event/event.nit

request: bin-dir
	nitc -o bin/request src/http/request.nit

server: bin-dir
	nitc -o bin/server -I lib/ -I src/http/ -I src/config/ src/server.nit

clean:
	rm -rf bin/*
=======
default: server

bin-dir:
	mkdir -p bin

event: bin-dir
	nitc -o bin/event lib/event/event.nit

server: bin-dir
	nitc -o bin/server -I lib/ src/server.nit

clean:
	rm -rf bin/*
>>>>>>> Stashed changes

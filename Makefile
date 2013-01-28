default: event

bin-dir:
	mkdir -p bin

event: bin-dir
	nitc -o bin/event lib/event/event.nit

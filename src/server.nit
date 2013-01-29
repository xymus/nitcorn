import event

class HttpServer
super Server
    redef fun read(line : String) do
        close
    end
end

class HttpServerFactory
super Factory
    redef fun make_server(c: Connection): Server do
        return new HttpServer(self, c)
    end
end


var e : EventBase = new EventBase.create_base
var listener = new ConnectionListener.bind_to(e, "localhost", 12345, new HttpServerFactory)

print "running"
e.dispatch

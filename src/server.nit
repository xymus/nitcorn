import event

class HttpServer
super Server
    redef fun read(line : String) do
        print line
        self.close
    end
end

class HttpServerFactory
super Factory
    redef fun make_server : Server do
        print "created http reactor"
        return new HttpServer(self)
    end
end


var e : EventBase = new EventBase.create_base
var listener = new ConnectionListener.bind_to(e, "localhost", 12345, new HttpServerFactory)

print "running"
e.dispatch

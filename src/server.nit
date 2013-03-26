import event
import request

class HttpServer
super Server

    var new_connection = false

    var request : Request = new Request

    redef fun read(line : String) do
        request.parse_line(line)
        #write("got your string: {line}\n")
        send_file("/home/jp/Projects-ssd/nit-webserver/test.html")
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

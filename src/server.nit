import event
import http_parser


class HttpServer
super Server

    var buffer_request : Buffer = new Buffer

    redef fun read(line : String) do
        print "got line '{line}'"
        if line == "" then
            print "got full request, must be parsed : {buffer_request.to_s}"
            var parser = new HttpParser
            parser.parse_request(buffer_request.to_s)

        else
            buffer_request.append(line)
            buffer_request.append("\r\n")
        end
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

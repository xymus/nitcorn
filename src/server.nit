import event
import config
import http_parser

class HttpServer
super Server

    var buffer_request : Buffer = new Buffer
    private var config : nullable Config

    redef fun read(line : String) do
        print "got line '{line}'"
        if line == "" then
            print "got full request, must be parsed : {buffer_request.to_s}"
            var parser = new HttpParser
            dispatch(parser.parse_request(buffer_request.to_s))
        else
            buffer_request.append(line)
            buffer_request.append("\r\n")
        end
    end

    fun dispatch(request: HttpRequest) do
        #let's find the virtual host

    end
    

end

class HttpServerFactory
super Factory
    var config : Config

    init do
        config = new Config("nitcorn")
        #Setting default hosts
        config.get_hostsmanager.set_default_host(
            new VirtualHost("localhost", new Ip([127,0,0,1]), 80, "/var/www")
        )
    end


    redef fun make_server(c: Connection): HttpServer do
        var s = new HttpServer(self, c)
        s.config = config
        return s
    end
end


var e : EventBase = new EventBase.create_base
var listener = new ConnectionListener.bind_to(e, "localhost", 12345, new HttpServerFactory)


print "running"
e.dispatch

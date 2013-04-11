import event
import config
import http_parser
import http_response

class HttpServer
super Server

    var buffer_request : Buffer = new Buffer
    private var config : nullable Config

    redef fun read(line : String) do
        buffer_request.append(line)
        var parser = new HttpParser
        answer(parser.parse_request(buffer_request.to_s))
    end

    fun answer(request: HttpRequest) do
        #todo find host
        var h = config.get_hostsmanager.get_default_host

        var headers = new HashMap[String, String]
        var response = new HttpResponse(request.get_version, 200, "OK", headers, "Hello world")
        write(response.to_s)
        close
    end
end

class HttpServerFactory
super Factory
    var config : Config

    init do
        config = new Config("nitcorn")
        #Setting default hosts
        config.get_hostsmanager.set_default_host(
            new Host("localhost", "/var/www/", new Mimes)
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

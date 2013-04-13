module server

import event
import config
import http_parser
import http_response
import http_status_codes

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
        headers["Server"] = "Nitcorn"

        var http_codes = new HttpStatusCodes

        var response = new HttpResponse("HTTP/1.0", 200, http_codes.get_status_message(200), headers, "")

        if config.get_accepted_methods.has(request.get_method) then
            if "{h.get_root}{request.get_url}".file_exists then
                if request.get_url.last != '/' then
                    var file = new IFStream.open("{h.get_root}{request.get_url}")
                    response.set_response_body(file.read_all)
                else
                    var body = new Buffer
                    var files = "{h.get_root}{request.get_url}".files
                    body.append("{h.get_root}:\n")
                    for file in files do
                        body.append("{file}\n")
                    end
                    response.set_response_body(body.to_s)
                end
                headers["Content-Length"] = response.get_response_body.length.to_s
            else
                response.set_status_code(404)
                response.set_status_message(http_codes.get_status_message(404))
            end
        else
            response.set_status_code(405)
            response.set_status_message(http_codes.get_status_message(405))
        end
        write(response.to_s)
        close
    end
end

class HttpServerFactory
super Factory
    var config : Config

    init (c: Config) do config = c

    redef fun make_server(c: Connection): HttpServer do
        var s = new HttpServer(self, c)
        s.config = config
        return s
    end
end


var config = new Config("nitcorn")
#Setting default hosts
config.get_hostsmanager.set_default_host(
    new VirtualHost("localhost", 80, new Array[String], "/var/www", new Mimes)
)

var e : EventBase = new EventBase.create_base
var listener = new ConnectionListener.bind_to(e, "localhost", 80, new HttpServerFactory(config))


print "running"
e.dispatch

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
        headers["Server"] = "Nitcorn"

        var response = new HttpResponse(request.get_version, 200, "OK", headers, "")
        if "{h.get_root}{request.get_url}".file_exists then
            if request.get_url.last != '/' then
                var file = new IFStream.open("{h.get_root}{request.get_url}")
                print "Getting file {h.get_root}{request.get_url}"
                response.set_response_body(file.read_all)
            else
                var body = new Buffer
                var files = "{h.get_root}{request.get_url}".files
                print "Getting files for {h.get_root}{request.get_url}"
                body.append("{h.get_root}:\n")
                for file in files do
                    body.append("{file}\n")
                end
                response.set_response_body(body.to_s)
            end
            headers["Content-Length"] = response.get_response_body.length.to_s
        else
            print "{h.get_root}{request.get_url} not found"
            response.set_status_code(400)
            response.set_status_message("File not found")
        end
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
            new Host("localhost", "/var/www", new Mimes)
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

module simple_hello_world

import http_response
import server
redef class HttpServer

    redef fun answer(http_request: HttpRequest) do
        var response = new HttpResponse("HTTP/1.0", 200, "OK", new HashMap[String, String], "Hello world")
        write(response.to_s)
        close
    end
end

var config = new Config("nitcorn")
#Setting default hosts
config.get_hostsmanager.set_default_host(
    new VirtualHost("localhost", 8080, new Array[String], "src/example-app/public_html", new Mimes)
)

var e : EventBase = new EventBase.create_base
var listener = new ConnectionListener.bind_to(e, "localhost", 8080, new HttpServerFactory(config))

config.get_logmanager.log("DEBUG", "Server started, listening on port 8080")
e.dispatch

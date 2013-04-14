module app

import server
import action
import home_action
import hello_world_action

class Application
    var http_request : HttpRequest
    var router : HashMap[String, Action]
    var template_dir = "src/example-app/templates"


    init(r: HttpRequest) do
        http_request = r
        router = new HashMap[String, Action]

        router["/hello_world/"] = new HelloWorldAction(http_request)
        router["/"] = new HomeAction(http_request)
    end

    fun execute: HttpResponse do
        for key,action in router do
            if http_request.get_url == "/" then
                return router["/"].execute("")
            end
            if http_request.get_url.substring(0, key.length) == key and key != "/" then
                var response = action.execute(http_request.get_url.substring_from(key.length - 1))
                if not action.render_file is null then
                    var file = new IFStream.open("{template_dir}/{action.render_file.as(not null)}")
                    response.set_response_body(file.read_all)
                end
                return response
            end
        end

        var a = new Action(http_request)
        return a.return_404
    end
end

redef class HttpServer

    redef fun answer(http_request: HttpRequest) do
        if http_request.get_url.substring(0, 8) == "/static/" then
            super(http_request)
            close
        else
            var app = new Application(http_request)
            var response =  app.execute
            response.set_version("HTTP/1.0")
            if response.get_response_field("Content-Type") == "" then
                response.set_response_field("Content-Type", "text/html; charset=utf-8")
            end
            write(response.to_s)
            close
        end
    end
end

var config = new Config("nitcorn")
#Setting default hosts
config.get_hostsmanager.set_default_host(
    new VirtualHost("localhost", 80, new Array[String], "src/example-app/public_html", new Mimes)
)

var e : EventBase = new EventBase.create_base
var listener = new ConnectionListener.bind_to(e, "localhost", 8080, new HttpServerFactory(config))

print "listening"
e.dispatch

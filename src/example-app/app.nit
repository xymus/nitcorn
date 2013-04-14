module app

import server
import action
import home_action
import hello_world_action
import config_action

class Application
    var server_config : Config
    var http_request : HttpRequest
    var router : HashMap[String, Action]
    var template_dir = "src/example-app/templates"

    init(r: HttpRequest, c : Config) do
        http_request = r
        server_config = c
        router = new HashMap[String, Action]

        router["/hello_world/"] = new HelloWorldAction(http_request)
        router["/"] = new HomeAction(http_request)
        router["/edit_config/"] = new ConfigAction(http_request)
    end

    fun execute: HttpResponse do
        for key,action in router do
            if http_request.get_field("path") == "/" then
                return router["/"].execute("")
            end
            if http_request.get_field("path").substring(0, key.length) == key and key != "/" then
                var module_name = ""
                if http_request.get_field("url").substring_from(key.length - 1) != "/" then
                    module_name =  http_request.get_field("url").substring_from(key.length)
                end
                var response = action.execute(module_name)
                if not action.render_file is null then
                    print("{template_dir}/{action.render_file.as(not null)}")
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
        if http_request.get_field("url").substring(0, 8) == "/static/" then
            super(http_request)
            close
        else
            var app = new Application(http_request,config.as(not null))
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
    new VirtualHost("localhost", 12345, new Array[String], "src/example-app/public_html", new Mimes)
)

var e : EventBase = new EventBase.create_base
var listener = new ConnectionListener.bind_to(e, "localhost", 8080, new HttpServerFactory(config))

print "listening"
e.dispatch

module nitcorn_app

import nitcorn

import home_action
import nitcorn_hello_world

class Application
    var server_config : Config
    var http_request : HttpRequest
    var router : HashMap[String, Action]
    var template_dir = "nitcorn_app/templates"

    init(r: HttpRequest, c : Config) do
        http_request = r
        server_config = c
        router = new HashMap[String, Action]

        router["/hello_world/"] = new HelloWorldAction(http_request)
        router["/"] = new HomeAction(http_request)
        router["/edit_config/"] = new ConfigAction(http_request, server_config)
    end

    fun execute: HttpResponse do
        for key,action in router do
            if http_request.url == "/" then
                return router["/"].execute("")
            end
            if http_request.url.substring(0, key.length) == key and key != "/" then
                var module_name = ""
                if http_request.url.substring_from(key.length - 1) != "/" then
                    module_name =  http_request.uri.substring_from(key.length)
                end
                var response = action.execute(module_name)
                if not action.render_file == null then
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

class ConfigAction
    super Action

    var config: Config 

    init(http_request: HttpRequest, server_config: Config) do
        super(http_request)
        config = server_config
    end

    redef fun execute(module_name: String): HttpResponse do
        if http_request.method != "GET" then
            return new HttpResponse("HTTP/1.0", 400 , http_codes.get_status_message(400), new HashMap[String, String], "")
    	end

        if module_name == "root" then
            if not http_request.params.has_key("path") then
                return new HttpResponse("HTTP/1.0", 405 , http_codes.get_status_message(405), new HashMap[String, String], "Missing path value\n")
            end
            var path = http_request.params["path"]
            if not path.file_exists then
                return new HttpResponse("HTTP/1.0", 405 , http_codes.get_status_message(405), new HashMap[String, String], "Path does not exists\n")
            end
            config.get_hostsmanager.get_default_host.set_root(path)
        end

        return new HttpResponse("HTTP/1.0", 200 , http_codes.get_status_message(200), new HashMap[String, String], "")
    end

end

redef class HttpServer

    redef fun answer(http_request: HttpRequest) do
        if http_request.url.substring(0, 8) == "/static/" then
            super(http_request)
            close
        else
            var app = new Application(http_request, config)
            var response =  app.execute
            response.set_version("HTTP/1.0")
            if response.get_response_field("Content-Type") == "" then
                response.set_response_field("Content-Type", "text/html; charset=utf-8")
            end
            config.get_logmanager.log("HTTP", "{http_request.url} {response.get_status_code}")
            write(response.to_s)
            close

        end
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

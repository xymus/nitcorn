module app

import server
import action
import home_action
import hello_world_action

class Application
    var http_request : HttpRequest
    var router : HashMap[String, Action]

    init(r: HttpRequest) do
        http_request = r
        router = new HashMap[String, Action]

        router["/hello_world"] = new HelloWorldAction(http_request)
        router["/"] = new HomeAction(http_request)
    end

    fun execute: HttpResponse do
        if http_request.get_url == "/" then
            return router["/"].execute("")
        else
            for key,action in router do
                print "{http_request.get_url} {key}"
                if http_request.get_url == key then
                    print "got key {key}"
                    return action.execute("")
                end
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
            write(response.to_s)
            close
        end
    end
end


var config = new Config("nitcorn")
#Setting default hosts for static files
config.get_hostsmanager.set_default_host(
    new Host("localhost", "/home/jp/Projects-ssd/nit-webserve", new Mimes)
)

var e : EventBase = new EventBase.create_base
var listener = new ConnectionListener.bind_to(e, "localhost", 8080, new HttpServerFactory(config))

e.dispatch

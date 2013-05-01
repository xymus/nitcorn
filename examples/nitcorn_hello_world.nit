module nitcorn_hello_world

import nitcorn

class HelloWorldAction
    super Action
    
    redef fun execute(module_name: String): HttpResponse do

        if module_name == "" then
            set_render_file("hello_world.html")
            return new HttpResponse("HTTP/1.0", 200, http_codes.get_status_message(200), new HashMap[String, String], "")
        else
            if ["bleu", "rouge", "vert"].has(module_name) then
                var input = new IFStream.open("data.txt")
                var data = input.read_line.split_with("|")
                input.close
                if module_name == "bleu" then
                    data[0] = (data[0].to_i + 1).to_s 
                else if module_name == "rouge" then
                    data[1] = (data[1].to_i + 1).to_s 
                else
                    data[2] = (data[2].to_i + 1).to_s 
                end
                var output = new OFStream.open("data.txt")
                output.write("{data[0]}|{data[1]}|{data[2]}")
                output.close

                var to_json = new ArrayMap[String, Int]
                to_json["bleu"] = data[0].to_i
                to_json["rouge"] = data[1].to_i
                to_json["vert"] = data[2].to_i

                var headers = new HashMap[String, String]
                headers["Content-Type"] = "application/json"

                return new HttpResponse("HTTP/1.0", 200, http_codes.get_status_message(200), headers, "\{\"bleu\": {data[0]}, \"rouge\": {data[1]}, \"vert\": {data[2]}\}")
            else if module_name == "get_data.csv" then
                var input = new IFStream.open("data.txt")
                var data = input.read_line.split_with("|")
                input.close
                var headers = new HashMap[String, String]
                headers["Content-Type"] = "text/csv"

                return new HttpResponse("HTTP/1.0", 200, http_codes.get_status_message(200), headers, "color,total\nbleu,{data[0]}\nrouge,{data[1]}\nvert,{data[2]}\n")
            else
                return new HttpResponse("HTTP/1.0", 404, http_codes.get_status_message(404), new HashMap[String, String], "")
            end
        end
    end
end

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
    new VirtualHost("localhost", 8080, new Array[String], "examples/nitcorn_www/", new Mimes)
)

var e : EventBase = new EventBase.create_base
var listener = new ConnectionListener.bind_to(e, "localhost", 8080, new HttpServerFactory(config))

config.get_logmanager.log("DEBUG", "Server started, listening on port 8080")
e.dispatch

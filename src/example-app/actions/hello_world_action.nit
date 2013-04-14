module hello_world_action
import action

class HelloWorldAction
super Action
    
    redef fun execute(module_name: String): HttpResponse do

        if module_name == "" then
            set_render_file("hello_world.html")
            return new HttpResponse(http_request.get_version, 200, http_codes.get_status_message(200), new HashMap[String, String], "")
        else

            return new HttpResponse(http_request.get_version, 200, http_codes.get_status_message(200), new HashMap[String, String], "got {module_name}")
        end

    end

end

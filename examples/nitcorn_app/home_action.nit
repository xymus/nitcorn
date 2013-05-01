module home_action

import nitcorn

class HomeAction
	super Action
    
    redef fun execute(module_name: String): HttpResponse do

        return new HttpResponse("HTTP/1.0", 200, http_codes.get_status_message(200), new HashMap[String, String], "<h1>Nitcorn</h1><a href=\"/hello_world/\">Hello world here</a>")
    end

end

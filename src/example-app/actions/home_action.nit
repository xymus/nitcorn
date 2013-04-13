module home_action
import action

class HomeAction
super Action
    
    redef fun execute(module_name: String): HttpResponse do

        return new HttpResponse(http_request.get_version, 200, http_codes.get_status_message(200), new HashMap[String, String], "")
    end

end

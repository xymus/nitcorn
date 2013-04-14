#Nitcorn
#App to change config
#Frederic Sevillano SEVF26078308
#INM5151-10

module config_action
import action

class ConfigAction
super Action
    
    redef fun execute(module_name: String): HttpResponse do
    	if http_request.get_field("method") == "GET" and http_request.get_field("status_code") == "200" then

    		return new HttpResponse(http_request.get_field("version"), 200, http_codes.get_status_message(200), new HashMap[String, String], "")
    	end
    	
    	return new HttpResponse(http_request.get_field("version"), 405, http_codes.get_status_message(405), new HashMap[String, String], "")
    end	
end
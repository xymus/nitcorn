#Nitcorn
#REST config Manager
#Frederic Sevillano SEVF26078308
#INM5151-10

module config_manager

import http_request
import http_response

class ConfigManager
	
	private var accepted_methods: Array[String] 

	init
	do
	 	accepted_methods = ["GET","POST"]
	end

	fun edit_config(edit_config_request: HttpRequest): HttpResponse
	do
	  	if edit_config_request.get_method == accepted_methods[0] then
			return get_req(edit_config_request)
		else if edit_config_request.get_method == accepted_methods[1] then
			return post_req(edit_config_request)
		else
			return bad_request(edit_config_request)
		end
	end

	private fun get_req(edit_config_request: HttpRequest): HttpResponse
	do 
		return new HttpResponse("HTTP/1.1", 400, "Bad Request", new HashMap[String, String],"")
	end

	private fun post_req(edit_config_request: HttpRequest): HttpResponse
	do
		return new HttpResponse("HTTP/1.1", 400, "Bad Request", new HashMap[String, String],"")
	end

	private fun bad_request(edit_config_request: HttpRequest): HttpResponse
	do
		return new HttpResponse("HTTP/1.1", 400, "Bad Request", new HashMap[String, String],"")
	end  
end
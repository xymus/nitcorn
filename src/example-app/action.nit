module action

import http_response
import http_request
import http_status_codes

class Action

    var http_request : HttpRequest
    var http_codes = new HttpStatusCodes

    fun return_404 : HttpResponse do
        return new HttpResponse(http_request.get_version, 404, http_codes.get_status_message(404), new HashMap[String, String], "")
    end

    fun execute(module_name: String): HttpResponse is abstract
end

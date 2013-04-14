module action

import http_response
import http_request
import http_status_codes

class Action

    var http_request : HttpRequest
    var http_codes = new HttpStatusCodes
    var render_file : nullable String

    init(r: HttpRequest) do http_request = r

    fun return_404 : HttpResponse do
        return new HttpResponse("HTTP/1.0", 404, http_codes.get_status_message(404), new HashMap[String, String], "")
    end

    fun execute(module_name: String): HttpResponse is abstract

    fun set_render_file(file: String) do render_file = file
end

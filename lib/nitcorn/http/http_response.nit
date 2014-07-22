#Nitcorn
#Reponse HTTP
#Frederic Sevillano SEV26078308
#INM5151-10

module http_response

class HttpResponse

		private var version: String
	private var status_code: Int
	
	private var status_message: String
	private var response_header_fields: HashMap[String, String]
	private var response_body: String
	
	fun set_version(version: String) do self.version = version  

	fun set_status_code(status_code: Int) do self.status_code = status_code
	
	fun set_status_message(status_message: String) do self.status_message = status_message
 
	fun set_response_field(field, value: String) do response_header_fields[field] = value 
	
	fun set_response_body(response_body: String) do self.response_body = response_body 


	fun get_version: String do return version

	fun get_status_code: Int do return status_code

	fun get_status_message: String do return status_message

	fun get_response_body: String do return response_body

	fun get_response_field(key: String) : String
	do
		if response_header_fields.keys.has(key) then
			return response_header_fields[key]
		else
			return ""
		end
	end 

    redef fun to_s : String do
        var buf = new FlatBuffer
        buf.append("{version} {status_code} {status_message}\r\n")
        #response_header_fields["Content-Length"] = response_body.length.to_s
        for key,value in response_header_fields do
            buf.append("{key}: {value}\r\n")
        end
        buf.append("\r\n{response_body}")
        return buf.to_s
    end

end

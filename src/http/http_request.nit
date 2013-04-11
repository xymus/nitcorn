#Nitcorn
#Decodage des requetes HTTP
#Frederic Sevillano SEVF26078308
#INM5151-10

module http_request

class HttpRequest

	private var method: String
	private var url: String
	private var version: String
	private var body: String
	private var status_code: Int
	private var header_fields: HashMap[String, String]

	fun set_method(method: String) do self.method = method

	fun set_version(version: String) do self.version = version

	fun set_url(url: String) do self.url = url	

	fun set_body(body: String) do self.body = body

	fun set_status_code(status_code: Int) do self.status_code = status_code

	fun set_field(field, value: String) do header_fields[field] = value
	
	
	fun get_status_code: Int do return status_code

	fun get_method: String do return method

	fun get_url: String do return url

	fun get_version: String do return version
	
	fun get_body: String do return body

    fun get_host: String do return get_header("Host")

    fun get_header(key: String) : String
    do
		if header_fields.keys.has(key) then 
			return header_fields[key] 
		else
			return ""
		end
	end
end

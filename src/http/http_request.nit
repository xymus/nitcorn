#Nitcorn
#Decodage des requetes HTTP
#Frederic Sevillano SEVF26078308
#INM5151-10

module http_request

class HttpRequest

	private var method: nullable String
	private var url: nullable String
	private var version: nullable String
	private var body: nullable String
	private var reply: nullable Int
	private var header_fields: HashMap[String, String] = new HashMap[String,String]

	init
	do
		method = null
		url = null
		version = null
		body = null
		reply = null
	end

	fun set_method(method: String) do self.method = method

	fun set_version(version: String) do self.version = version

	fun set_url(url: String) do self.url = url	

	fun set_body(body: String) do self.body = body

	fun set_reply(reply: Int) do self.reply = reply

	fun set_field(field, value: String) do header_fields[field] = value
	
	
	fun get_reply: nullable Int do return reply

	fun get_method: nullable String do return method

	fun get_url: nullable String do return url

	fun get_version: nullable String do return version
	
	fun get_body: nullable String do return body

	fun get(field: String): nullable String
	do
		if header_fields.has_key(field) then
			return header_fields[field]
		else
			return null
		end
	end		
end

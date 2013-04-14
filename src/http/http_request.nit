#Nitcorn
#Decodage des requetes HTTP
#Frederic Sevillano SEVF26078308
#INM5151-10

module http_request

class HttpRequest

	private var fields: HashMap[String, String]

	init
	do
		self.fields = new HashMap[String,String]
	end

	init full(fields: HashMap[String,String])
	do
		self.fields = fields
	end

	fun set_field(field, value: String) do fields[field] = value
	
    fun get_field(key: String) : String
    do
		if fields.keys.has(key) then 
			return fields[key] 
		else
			return ""
		end
	end

	fun get_method : String do return fields["method"] end

	fun get_url : String do return fields["url"] end

	fun get_version : String do return fields["version"] end
end

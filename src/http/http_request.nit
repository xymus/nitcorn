#Nitcorn
#Decodage des requetes HTTP
#Frederic Sevillano SEVF26078308
#INM5151-10

module http_request

class HttpRequest

    var http_version : String = ""
    var method : String = ""
    var host : String = ""
    var url : String = ""
    var uri : String = ""
    var query_string : String = ""
    var params : ArrayMap[String, String] = new ArrayMap[String, String]
    var headers : ArrayMap[String, String] = new ArrayMap[String, String]
    var body : String = ""

	fun set_header(header, value: String) do headers[header] = value
	
    fun get_header(key: String) : String
    do
		if headers.keys.has(key) then 
			return headers[key] 
		else
			return ""
		end
	end
end

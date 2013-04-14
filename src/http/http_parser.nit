#Nitcorn
#Decodage des requetes HTTP
#Frederic Sevillano SEVF26078308
#INM5151-10

module http_parser

intrude import http_request

class HttpParser

    var body: String = ""
	var header_fields: Array[String] = new Array[String]
	var first_line: Array[String] = new Array[String]
    var fields : HashMap[String, String] = new HashMap[String, String]
    var http_request = new HttpRequest

	fun parse_http_request(full_request: String) : HttpRequest
	do	
		clear_data

		segment_http_request(full_request)
        
        http_request.http_version = first_line[2]
        http_request.url = first_line[1]
        if http_request.url.has('?') then 
            http_request.uri = first_line[1].substring(0, first_line[1].index_of('?'))
            http_request.query_string = first_line[1].substring_from(first_line[1].index_of('?')+1)
            http_request.params = parse_url
        else
            http_request.uri = first_line[1]
        end
        http_request.method = first_line[0]

		for i in header_fields do
			var temp_field = i.split_with(": ")

			if temp_field.length == 2 then
				http_request.headers[temp_field[0]] = temp_field[1]
			end				
		end

        return http_request
	end

	private fun clear_data
	do
		first_line.clear
		header_fields.clear
	end

	private fun segment_http_request(http_request: String): Bool 
	do		
		var temp_place = "\r\n\r\n".search_index_in(http_request, 0)

		if temp_place < 0 then
			header_fields = http_request.split_with("\r\n")
		else
			header_fields = http_request.substring(0, temp_place).split_with("\r\n")
			body = http_request.substring(temp_place+4, http_request.length-1)
		end
		
		## If a line of the http_request is long it may change line, it has " " at the end to indicate this.
		## This section turns them into 1 line.

		if header_fields.length > 1 and header_fields[0].has_suffix(" ") then
			var temp_req = header_fields[0].substring(0, header_fields[0].length-1) + header_fields[1]
			
			first_line  = temp_req.split_with(' ')
			header_fields.shift
			header_fields.shift

			if first_line.length != 3 then return false 

		else
			first_line = header_fields[0].split_with(' ')
			header_fields.shift

			if first_line.length != 3 then return false
		end

		var pos = 0
		while pos < header_fields.length do
			if pos < header_fields.length-1 and header_fields[pos].has_suffix(" ") then
				header_fields[pos] = header_fields[pos].substring(0, header_fields[pos].length-1) + header_fields[pos+1]
				header_fields.remove_at(pos+1)
				pos = pos-1
			end
			pos = pos+1
		end

		return true
	end

    private fun parse_url : ArrayMap[String, String]
	do
        var query_strings = new ArrayMap[String, String]

		if http_request.url.has('?') then 
            var params = http_request.query_string.split_with("&")
            for param in params do
                var key_value = param.split_with("=")
                query_strings[key_value[0]] = key_value[1]
            end
		end

        return query_strings
	end
end

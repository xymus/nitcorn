#Nitcorn
#Decodage des requetes HTTP
#Frederic Sevillano SEVF26078308
#INM5151-10

module http_parser

import http_request

class HttpParser

	private var method_types: Array[String]
	private var version_types: Array[String]

	private var header_fields: Array[String] = new Array[String]
	private var first_line: Array[String] = new Array[String]
    private var fields : HashMap[String, String] = new HashMap[String, String]
	
	init
	do
		method_types = ["GET","POST","PUT","HEAD","OPTIONS","DELETE","TRACE","CONNECT"]
		version_types = ["HTTP/1.0","HTTP/1.1"]
	end

	fun parse_request(request: String) : HttpRequest
	do	
		clear_data

		if request.has_prefix(" ") then return response_error("400")

		if not segment_request(request) then return response_error("400")
			 
		if not check_method then return response_error("400")

		if not check_version then return response_error("400")

		if not find_path_variables then return response_error("400")

		if not insert_fields then return response_error("400")

		fields["status_code"] = "200"

        return new HttpRequest.full(fields)
	end

	private fun clear_data
	do
		fields.clear
		first_line.clear
		header_fields.clear
	end

	private fun segment_request(request: String): Bool 
	do		
		var temp_place = "\r\n\r\n".search_index_in(request, 0)

		if temp_place < 0 then
			header_fields = request.split_with("\r\n")
		else
			header_fields = request.substring(0, temp_place).split_with("\r\n")
			fields["body"] = request.substring(temp_place+4, request.length-1)
		end
		
		## If a line of the request is long it may change line, it has " " at the end to indicate this.
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

		fields["method"] = first_line[0]
		fields["url"] = first_line[1]
		fields["version"] = first_line[2]

		return true
	end
	
	private fun check_method: Bool 
	do 
		for i in method_types 
		do 
			if fields["method"] == i then return true
		end
		return false
	end
	
	private fun check_version: Bool	
	do
		for i in version_types
		do
			if fields["version"] == i then return true 
		end
		return false
	end

	private fun find_path_variables: Bool
	do
		var no_problem = true
		var temp_path_variables = first_line[1].split_with("?")
		var count = 1

		if temp_path_variables.length <= 0 then 
			no_problem = false
		else if temp_path_variables.length == 1 then 
			fields["path"] = temp_path_variables[0]
		else
			fields["path"] = temp_path_variables[0]
			temp_path_variables.remove_at(0)

			for i in temp_path_variables do
				var temp_string = "var" + count.to_s
				fields[temp_string] = i
				count += 1
			end
		end

		return no_problem
	end

	private fun insert_fields: Bool
	do
		var no_problem = true

		for i in header_fields do
			var temp_field = i.split_with(": ")

			if temp_field.length != 2 then
				no_problem = false	
			else 
				fields[temp_field[0]] = temp_field[1]
			end				
		end

		return no_problem	
	end	

	private fun response_error(err_num: String): HttpRequest
	do
		fields["status_code"] = err_num
		return new HttpRequest.full(fields)
	end
end
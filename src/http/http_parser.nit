#Nitcorn
#Decodage des requetes HTTP
#Frederic Sevillano SEVF26078308
#INM5151-10

module http_parser

import http_request

class HttpParser
	
	private var method_types: Array[String]
	private var version_types: Array[String]	

	private var req_line:  Array[String]
	private var req_fields: Array[String]
	private var status_code: Int
	private var body: String
    private var fields : HashMap[String, String] = new HashMap[String, String]

	init
	do
		method_types = ["GET","POST","PUT","HEAD","OPTIONS","DELETE","TRACE","CONNECT"]
		version_types = ["HTTP/1.0 ","HTTP/1.1"]	

		req_fields = new Array[String]
		req_line = new Array[String]
		status_code = 200
		body = ""
	end

	fun parse_request(request: String) : HttpRequest
	do	
		clean_variables

		if not request.has_prefix(" ") then
	
			segment_request(request)	
		
			if not check_req_line then
				status_code = 400
			end	
		else
			status_code = 400
		end

		if not insert_fields then status_code = 400

        return new HttpRequest(req_line[0], req_line[1], req_line[2], body,
            status_code, fields)
	end

	private fun clean_variables
	do
		req_fields.clear
		req_line.clear
		body = ""
		status_code = 200
	end

	private fun segment_request(req: String) 
	do		
		var temp_place = "\r\n\r\n".search_index_in(req, 0)

		if temp_place < 0 then
			req_fields = req.split_with("\r\n")
		else
			req_fields = req.substring(0, temp_place).split_with("\r\n")
			body = req.substring(temp_place+4, req.length-1)
		end
		
		if req_fields.length > 1 and req_fields[0].has_suffix(" ") then
			var temp_req = req_fields[0].substring(0, req_fields[0].length-1) + req_fields[1]
			
			req_line = temp_req.split_with(' ')
			req_fields.shift
			req_fields.shift
		else
			req_line = req_fields[0].split_with(' ')
			req_fields.shift
		end

		var pos = 0
		while pos < req_fields.length do
			if pos < req_fields.length-1 and req_fields[pos].has_suffix(" ") then
				req_fields[pos] = req_fields[pos].substring(0, req_fields[pos].length-1) + req_fields[pos+1]
				req_fields.remove_at(pos+1)
				pos = pos-1
			end
			pos = pos+1
		end
	end
	
	private fun check_req_line: Bool
	do
		if req_line.length != 3 then return false
		if not check_method then return false
		if not check_version then return false

		return true		
	end
	
	private fun check_method: Bool 
	do
		for i in method_types 
		do 
			if i == req_line[0] then return true
		end

		return false
	end
	
	private fun check_version: Bool	
	do
		for i in version_types
		do
			if i == req_line[2] then return true 
		end

		return false
	end

	private fun insert_fields: Bool
	do
		var no_problem = true

		for i in req_fields do
			var temp_field = i.split_with(": ")

			if temp_field.length != 2 then
				no_problem = false	
			else 
				fields[temp_field[0]] = temp_field[1]
			end				
		end

		return no_problem
	end	
end

#Nitcorn
#Tests module http_response
#Frederic Sevillano SEVF26078308
#INM5151-10

module testresponse

import http_response
	
#Configuration
var test_response = new HttpResponse("HTTP/1.1", 400, "Bad Request", new HashMap[String, String],"")

var t_version = "HTTP/1.0"
var t_status_code = 200
var t_status_message = "OK"
var t_hash_key = "Etag"
var t_hash_value = "fa2ba873343ba638123b767c8c09998"
var t_body = "This is the body!"

test_response.set_version(t_version)
test_response.set_status_code(t_status_code)
test_response.set_status_message(t_status_message)
test_response.set_response_field(t_hash_key,t_hash_value)
test_response.set_response_body(t_body)

assert t_response_version:			test_response.get_version == t_version
assert t_response_status_code:		test_response.get_status_code == t_status_code
assert t_response_status_message:	test_response.get_status_message == t_status_message
assert t_response_field:			test_response.get_response_field(t_hash_key) == t_hash_value
assert t_response_body:				test_response.get_response_body == t_body
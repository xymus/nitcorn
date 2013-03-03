#Nitcorn 
#Tests http_parser et http_request
#Frederic Sevillano SEVF26078308
#INM5151-10

module testparser

import http_parser
import http_request

# Configuration

var test_parser = new HttpParser
var test_parsed_request = new HttpRequest

# Ensure default nulls in init of http_request

assert default_method: 	test_parsed_request.get_method == null
assert default_url: 	test_parsed_request.get_url == null
assert default_version: test_parsed_request.get_version == null
assert default_body: 	test_parsed_request.get_body == null
assert default_reply: 	test_parsed_request.get_reply == null
assert default_field: 	test_parsed_request.get("Anything") == null

# Ensure set_ values of http_request

var t_method = "GET"
var t_url = "https://justatest/goodday.nit"
var t_version = "HTTP/1.1"
var t_body = "this is a simple example for the set_body test"
var t_reply = 200
var t_field_name = "Host"
var t_field_value = "123.321.123.nit"

test_parsed_request.set_method(t_method)
test_parsed_request.set_url(t_url)
test_parsed_request.set_version(t_version)
test_parsed_request.set_body(t_body)
test_parsed_request.set_reply(t_reply)
test_parsed_request.set_field(t_field_name,t_field_value)

assert t_set_method: 	test_parsed_request.get_method == t_method
assert t_set_url: 	test_parsed_request.get_url == t_url
assert t_set_version: 	test_parsed_request.get_version == t_version
assert t_set_body: 	test_parsed_request.get_body == t_body
assert t_set_reply: 	test_parsed_request.get_reply == t_reply
assert t_set_field: 	test_parsed_request.get("Host") == t_field_value

# Ensure parsed_request values of http_parser

var test_request_string_one = "GET /test-url.nit HTTP/1.0\r\nHost: 123.222.666.nit" 
var test_request_string_two = "POST https://new-google.nit/world007.org HTTP/1.1\r\nConnection: Keep-Alive\r\n\r\nThis is the body"

var t_one_method = "GET" 
var t_one_url = "/test-url.nit" 
var t_one_version = "HTTP/1.0" 
var t_one_body = "" 
var t_one_reply = 200
var t_one_field_name = "Host"
var t_one_field_value = "123.222.666.nit"

var t_two_method = "POST" 
var t_two_url = "https://new-google.nit/world007.org" 
var t_two_version = "HTTP/1.1" 
var t_two_body = "This is the body" 
var t_two_reply = 200
var t_two_field_name = "Connection"
var t_two_field_value = "Keep-Alive"

test_parsed_request = test_parser.parse_request(test_request_string_one)

#assert t_parsed_method_one:	test_parsed_request.get_method == t_one_method 	
#assert t_parsed_url_one:	test_parsed_request.get_url == t_one_url 	
#assert t_parsed_version_one:	test_parsed_request.get_version == t_one_version 	
#assert t_parsed_body_one:	test_parsed_request.get_body == t_one_body 	
#assert t_parsed_reply_one:	test_parsed_request.get_reply == t_one_reply 	
#assert t_parsed_field_one:	test_parsed_request.get("Host") == t_one_field_value 	

test_parsed_request = test_parser.parse_request(test_request_string_two)

assert t_parsed_method_two:	test_parsed_request.get_method == t_two_method 	
assert t_parsed_url_two:	test_parsed_request.get_url == t_two_url 	
assert t_parsed_version_two:	test_parsed_request.get_version == t_two_version 	
assert t_parsed_body_two:	test_parsed_request.get_body == t_two_body 	
assert t_parsed_reply_two:	test_parsed_request.get_reply == t_two_reply 	
assert t_parsed_field_two:	test_parsed_request.get("Connection") == t_two_field_value 	

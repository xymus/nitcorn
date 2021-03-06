#Nitcorn 
#Tests http_parser et http_request
#Frederic Sevillano SEVF26078308
#INM5151-10

module testparser

import http_parser
import http_request

# Test http_request

var test_parsed_request = new HttpRequest

var t_method = "GET"
var t_url = "https://justatest/goodday.nit"
var t_version = "HTTP/1.1"
var t_body = "this is a simple example for the set_body test"
var t_status_code = "200"
var t_field_name = "Host"
var t_field_value = "123.321.123.nit"

test_parsed_request.set_field("method", t_method)
test_parsed_request.set_field("url", t_url)
test_parsed_request.set_field("version", t_version)
test_parsed_request.set_field("body", t_body)
test_parsed_request.set_field("status_code", t_status_code)
test_parsed_request.set_field(t_field_name,t_field_value)

assert t_set_method: 	test_parsed_request.get_field("method") == t_method
assert t_set_url: 	test_parsed_request.get_field("url") == t_url
assert t_set_version: 	test_parsed_request.get_field("version") == t_version
assert t_set_body: 	test_parsed_request.get_field("body") == t_body
assert t_set_status_code: 	test_parsed_request.get_field("status_code") == t_status_code
assert t_set_field: 	test_parsed_request.get_field("Host") == t_field_value

# Ensure parsed_request values of http_parser

var test_request_string_one = "GET /test-url.nit?allyourbases=arebelongtous?no=yes?HIGH HTTP/1.0\r\nHost: 123.222.666.nit\r\n\r\nThis is the body, This is my mind! Together we are one!" 
var parser = new HttpParser
var test2 = parser.parse_request(test_request_string_one)

print test2.get_field("method")
print test2.get_field("url")
print test2.get_field("version")
print test2.get_field("body")
print test2.get_field("var1")
print test2.get_field("var2")
print test2.get_field("var3")

print test2.get_field("Host")
test2.set_field("SpiderMan", "Red/Blue")
test2.set_field("BatMan", "Black/Yellow")
test2.set_field("Hulk", "Green")

print test2.get_field("Hulk")
print test2.get_field("BatMan")
print test2.get_field("SpiderMan")


#var test_request_string_two = "POST https://new-google.nit/world007.org HTTP/1.1\r\nConnection: Keep-Alive\r\n\r\nThis is the body"

#test_parsed_request = test_parser.parse_request(test_request_string_one)

#assert t_parsed_method_one:	test_parsed_request.get_method == t_one_method 	
#assert t_parsed_url_one:	test_parsed_request.get_url == t_one_url 	
#assert t_parsed_version_one:	test_parsed_request.get_version == t_one_version 	
#assert t_parsed_body_one:	test_parsed_request.get_body == t_one_body 	
#assert t_parsed_status_code_one:	test_parsed_request.get_status_code == t_one_status_code 	
#assert t_parsed_field_one:	test_parsed_request.get_header("Host") == t_one_field_value 	

#test_parsed_request = test_parser.parse_request(test_request_string_two)

#assert t_parsed_method_two:	test_parsed_request.get_method == t_two_method 	
#assert t_parsed_url_two:	test_parsed_request.get_url == t_two_url 	
#assert t_parsed_version_two:	test_parsed_request.get_version == t_two_version 	
#assert t_parsed_body_two:	test_parsed_request.get_body == t_two_body 	
#assert t_parsed_status_code_two:	test_parsed_request.get_status_code == t_two_status_code 	
#assert t_parsed_field_two:	test_parsed_request.get_header("Connection") == t_two_field_value
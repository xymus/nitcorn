#Nitcorn
#Tests module http_status_codes
#Frederic Sevillano SEVF26078308
#INM5151-10

module teststatuscodes

import http_status_codes

#Configuration
var test_status_codes = new HttpStatusCodes

# Test
assert t_ok_msg: test_status_codes.get_status_message(200) == "OK"
assert t_bad_req_msg: test_status_codes.get_status_message(400) == "Bad Request"
assert t_bad_key: test_status_codes.get_status_message(999) == ""

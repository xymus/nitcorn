module test_config

import mimes
import virtualhost
import config
import ip
import url_tree
import host


# Configuration

# Base values

var config_name = "test_config"

var config = new Config(config_name)

assert config_init_time_is_now: config.get_init_time == get_time
assert config_name: 			config.get_name == config_name

# Log paths

# Ensure we have a default path
assert default_error_log: 	config.get_log_error_path.length > 0
assert default_access_log: 	config.get_log_access_path.length > 0
assert default_info_log: 	config.get_log_info_path.length > 0
assert default_debug_log: 	config.get_log_debug_path.length > 0

# Set and get
var new_error_log 	= "log/newerror.log"
var new_access_log 	= "log/newaccess.log"
var new_info_log 	= "log/newinfo.log"
var new_debug_log 	= "log/newdebug.log"

config.set_log_error_path(new_error_log)
config.set_log_access_path(new_access_log)
config.set_log_info_path(new_info_log)
config.set_log_debug_path(new_debug_log)

assert get_set_error_log_path: 	config.get_log_error_path == new_error_log
assert get_set_access_log_path: config.get_log_access_path == new_access_log
assert get_set_info_log_path: 	config.get_log_info_path == new_info_log
assert get_set_debug_log_path: 	config.get_log_debug_path == new_debug_log

# Virtual Host

var hostsmanager = config.get_hostsmanager

var virtualhost1_name = "virtualhost1"
var virtualhost1_ip = new Ip([127,0,0,1])
var virtualhost1_port = 8080
var virtualhost1_alias = "www"
var virtualhost1 = hostsmanager.addnew_virtualhost(virtualhost1_name,
												   virtualhost1_ip,
												   virtualhost1_port,
												   virtualhost1_alias)
# Get are init values
assert get_init_virtualhost_name:	virtualhost1.get_name == virtualhost1_name
assert get_init_virtualhost_ip:		virtualhost1.get_ip == virtualhost1_ip
assert get_init_virtualhost_port:	virtualhost1.get_port == virtualhost1_port
assert get_init_virtualhost_alias:	virtualhost1.get_alias == virtualhost1_alias

# Default host
var defaulthost = hostsmanager.get_default_host
var newdefaulthost = new Host("new")
hostsmanager.set_default_host(newdefaulthost)
newdefaulthost = hostsmanager.get_default_host

var virtualhost2_name = "virtualhost2"
var virtualhost2_ip = new Ip([127,0,0,2])
var virtualhost2_port = 80
var virtualhost2_alias = ""
var virtualhost2 = hostsmanager.addnew_virtualhost(virtualhost2_name,
												   virtualhost2_ip,
												   virtualhost2_port,
												   virtualhost2_alias)

assert virtualhost1_has_default_host: virtualhost1.get_host == defaulthost
assert virtualhost2_has_new_default_host: virtualhost2.get_host == newdefaulthost
assert default_host_changed: defaulthost != newdefaulthost

# Virtual host routing

var routed1 = hostsmanager.get_host_for(virtualhost1_ip,
									    virtualhost1_port,
									    virtualhost1_alias)
var routed2 = hostsmanager.get_host_for(virtualhost2_ip,
									    virtualhost2_port,
									    virtualhost2_alias)

assert unknown_routed_ip:    hostsmanager.get_host_for(new Ip([192, 168, 1, 1]), virtualhost1_port, virtualhost1_alias) == null
assert unknown_routed_port:  hostsmanager.get_host_for(virtualhost1_ip, 4413, virtualhost1_alias) == null
assert unknown_routed_alias: hostsmanager.get_host_for(virtualhost1_ip, virtualhost1_port, "plus") == null
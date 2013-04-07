module testconfig

import mime
import virtualhost
import config
import ip
import host

# Configuration

# Base values

var config_name = "test_config"

var config = new Config(config_name)

assert config_init_time_is_now: config.get_init_time == get_time
assert config_name: 			config.get_name == config_name

# Log manager

var log = config.get_logmanager

# Ensure we have a default path
assert default_error_log: 	log.get_e_path.length > 0
assert default_access_log: 	log.get_a_path.length > 0
assert default_info_log: 	log.get_i_path.length > 0
assert default_debug_log: 	log.get_d_path.length > 0
assert default_verbose_log: log.get_v_path.length > 0
assert default_warning_log:	log.get_w_path.length > 0
assert default_wtf_log: 	log.get_wtf_path.length > 0

# Set and get
var new_error_log 	= "log/newerror.log"
var new_access_log 	= "log/newaccess.log"
var new_info_log 	= "log/newinfo.log"
var new_debug_log 	= "log/newdebug.log"
var new_verbose_log = "log/newverbose.log"
var new_warning_log = "log/newwarning.log"
var new_wtf_log 	= "log/newwtf.log"

log.set_e_path(new_error_log)
log.set_a_path(new_access_log)
log.set_i_path(new_info_log)
log.set_d_path(new_debug_log)
log.set_v_path(new_verbose_log)
log.set_w_path(new_warning_log)
log.set_wtf_path(new_wtf_log)


assert get_set_error_log_path: 		log.get_e_path == new_error_log
assert get_set_access_log_path: 	log.get_a_path == new_access_log
assert get_set_info_log_path: 		log.get_i_path == new_info_log
assert get_set_debug_log_path: 		log.get_d_path == new_debug_log
assert get_set_verbose_log_path:	log.get_v_path == new_verbose_log
assert get_set_warning_log_path:	log.get_w_path == new_warning_log
assert get_set_wtf_log_path: 		log.get_wtf_path == new_wtf_log

# Virtual Host and Host

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
var newdefaulthost = new Host("new", "./", hostsmanager.get_default_mimes)
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
									    
assert routed1: routed1 == virtualhost1.get_host
assert routed2: routed2 == virtualhost2.get_host

assert unknown_routed_ip:    null == hostsmanager.get_host_for(new Ip([192, 168, 1, 1]), virtualhost1_port, virtualhost1_alias)
assert unknown_routed_port:  null == hostsmanager.get_host_for(virtualhost1_ip, 4413, virtualhost1_alias)
assert unknown_routed_alias: null == hostsmanager.get_host_for(virtualhost1_ip, virtualhost1_port, "plus")

config.save_config


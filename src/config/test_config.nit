module test_config

import mimes
import virtualhost
import config
import ip
import url_tree
import host


# 1 : Configuration


var config_name = "test_config"

var config = new Config(config_name)

# Base values
assert config.get_init_time == get_time
assert config.get_name == config_name

# Ensure we have a default path
assert config.get_log_error_path.length > 0
assert config.get_log_access_path.length > 0
assert config.get_log_info_path.length > 0
assert config.get_log_debug_path.length > 0

# Change log
var new_error_log = "log/newerror.log"
var new_access_log = "log/newaccess.log"
var new_info_log = "log/newinfo.log"
var new_debug_log = "log/newdebug.log"

config.set_log_error_path(new_error_log)
config.set_log_access_path(new_access_log)
config.set_log_info_path(new_info_log)
config.set_log_debug_path(new_debug_log)

assert config.get_log_error_path == new_error_log
assert config.get_log_access_path == new_access_log
assert config.get_log_info_path == new_info_log
assert config.get_log_debug_path == new_debug_log

print config

# 1.1 : Virtual Host




var wc = new WebContent("index.html","text/html")

var root = new UrlTreeNode("", null, wc)

var h = new Host(root)

var ip = new Ip([127, 0, 0, 1])
print "ip: {ip.get_p(0)}.{ip.get_p(1)}.{ip.get_p(2)}.{ip.get_p(3)}"

var default = "text/plain"
var m = new Mimes(default)

var empty_ext = m.mime_for("")
var null_ext = m.mime_for(null)
var zip_ext = m.mime_for("zip")

print "empty ext meme: {empty_ext}"
print "null ext meme: {null_ext}"
print "zip ext meme: {zip_ext}"

print "loading basic mimes"
m.load_basic_memes
zip_ext = m.mime_for("zip")
print "zip ext meme: {zip_ext}"
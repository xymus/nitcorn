module test_config

import mimes
import virtualhost
import config
import ip
import url_tree
import host

# Tests

# Tests

var wc = new WebContent("index.html","text/html")

var root = new UrlTreeNode("", null, wc)

var h = new Host(root)

var vh = new VirtualHost("host1",new Ip([127,0,0,1]),8080,h)

# Tests

var config = new Config("test_config")

print "init time: {config.get_init_time}"
print "instance name: {config.get_name}"

# Tests

var ip = new Ip([127, 0, 0, 1])
print "ip: {ip.get_p(0)}.{ip.get_p(1)}.{ip.get_p(2)}.{ip.get_p(3)}"

# Tests

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
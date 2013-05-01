module nitcorn_file_server

import nitcorn

var config = new Config("nitcorn")
# Setting default hosts
config.get_hostsmanager.set_default_host(
    new VirtualHost("localhost", 8080, new Array[String], "examples/nitcorn_www/", new Mimes)
)

var e : EventBase = new EventBase.create_base
var listener = new ConnectionListener.bind_to(e, "localhost", 8080, new HttpServerFactory(config))

config.get_logmanager.log("DEBUG", "Server started, listening on port 8080")
e.dispatch

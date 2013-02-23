module virtualhost

import ip
import host

class VirtualHost

	private var name : String
	private var ip : Ip
	private var port : Int
	private var host : Host

	init(name : String, ip : Ip, port : Int, host : Host)
	do
		self.name = name
		self.ip = ip
		self.port = port
		self.host = host
	end

	fun get_name : String do return name

	fun get_ip : Ip do return ip

	fun get_port : Int do return port

	fun get_host : Host do return host

	fun set_host(host : Host) do self.host = host
end

# Tests

var h = new Host

var vh = new VirtualHost("host1",new Ip([127,0,0,1]),8080,h)
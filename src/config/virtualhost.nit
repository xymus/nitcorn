module virtualhost

import ip
import host

class VirtualHost

    private var name : String
	private var ip : Ip
	private var port : Int
	private var alias : String
    private var host : Host

	init(name : String, ip : Ip, port : Int, alias : String, host : Host)
	do
	    self.name = name
		self.ip = ip
		self.port = port
        self.alias = alias
        self.host = host
	end

    fun get_name : String do return name
	fun get_ip : Ip do return ip
	fun get_port : Int do return port
	fun get_alias : String do return alias
	fun get_host : Host do return host

end

module virtualhost

import ip
import host

class VirtualHost

	private var ip : Ip
	private var port : Int
	private var alias : Array[String] = new Array[String]
    private var root : String

	init(host : String, ip : Ip, port : Int, root : String)
	do
		self.ip = ip
		self.port = port
        self.root = root
        self.alias.push(host)
	end

    fun add_host(host : String) do alias.push(host) end

	fun get_ip : Ip do return ip
	fun get_port : Int do return port
	fun get_alias : Array[String] do return alias
end

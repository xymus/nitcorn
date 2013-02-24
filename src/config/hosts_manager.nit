module hosts_manager

import host
import virtualhost

class HostsManager

	private var default_host : Host
	
	type AliasRouter : HashMap[String, VirtualHost]
	type PortAliasRouter : HashMap[Int, AliasRouter]
	type IpPortAliasRouter : HashMap[Ip, PortAliasRouter]
	
	private var virtualhost_router : IpPortAliasRouter = new IpPortAliasRouter
	
	private var hosts : HashMap[String, Host] = new HashMap[String, Host]
	private var virtualhosts : HashMap[String, VirtualHost] = new HashMap[String, VirtualHost]

	init
	do
    	self.default_host = get_new_default_host
	end
    
    fun get_new_default_host : Host
    do
    	return new Host("default")
    end
    
    
    fun get_default_host : Host do return default_host
    fun set_default_host(host : Host) do default_host = host end

	fun addnew_virtualhost(name : String, ip : Ip, port : Int, alias : String) : VirtualHost
	do
		return addnew_virtualhost_with_host(name, ip, port, alias, default_host)
	end
	
	fun addnew_virtualhost_with_host(name : String, ip : Ip, port : Int, alias: String, host : Host) : VirtualHost
	do
		var vh = new VirtualHost(name, ip, port, alias, host)
		virtualhosts[name] = vh
		addnew_route_for_virtualhost(vh)
		hosts[host.get_name] = host
		return vh
	end
	
	private fun addnew_route_for_virtualhost(virtualhost : VirtualHost)
	do
		var port_alias_router
		if virtualhost_router.keys.has(virtualhost.get_ip) then
			port_alias_router = virtualhost_router[virtualhost.get_ip]
		else
			port_alias_router = new PortAliasRouter
			virtualhost_router[virtualhost.get_ip] = port_alias_router
		end
		
		var alias_router
		if port_alias_router.keys.has(virtualhost.get_port) then
			alias_router = port_alias_router[virtualhost.get_port]
		else
			alias_router = new AliasRouter
			port_alias_router[virtualhost.get_port] = alias_router
		end
		
		alias_router[virtualhost.get_alias] = virtualhost
	end
	
	fun get_host_for(ip : Ip, port : Int, alias : String) : nullable Host
	do
		var port_alias_router
		if virtualhost_router.keys.has(ip) then
			port_alias_router = virtualhost_router[ip]
		else
			return null
		end
		
		var alias_router
		if port_alias_router.keys.has(port) then
			alias_router = port_alias_router[port]
		else
			return null
		end
		
		if alias_router.keys.has(alias) then
			return alias_router[alias].get_host
		else
			return null
		end
	end
	
end
	
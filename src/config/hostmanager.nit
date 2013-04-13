module hostmanager

import virtualhost

class HostManager

    private var default_mimes : Mimes
	
	private var virtualhosts : Array[VirtualHost] = new Array[VirtualHost]

	private var default_host : VirtualHost

	type Router : HashMap[Int, HashMap[String, VirtualHost]]
	private var router : Router = new Router

	init
	do
	    self.default_mimes = get_new_default_mimes
	    self.default_host = get_new_default_host
	end
    
    private fun get_new_default_mimes : Mimes
    do
        var mimes : Mimes = new Mimes
        mimes.load_basic_mimes
        return mimes
    end

    fun set_default_host(h: VirtualHost) do default_host = h

    private fun get_new_default_host : VirtualHost
    do
    	return new VirtualHost("default",-1,[""],"./",default_mimes)
    end

    fun get_default_host : VirtualHost
    do
    	return default_host
    end
    
    fun get_default_mimes : Mimes do return default_mimes

    fun get_virtualhosts : ArrayIterator[VirtualHost] do return virtualhosts.iterator end

	fun addnew_virtualhost(name : String, port : Int, aliases : Array[String], root : String) : VirtualHost
	do
		var vh = new VirtualHost(name, port, aliases, root, default_mimes)
		virtualhosts.push(vh)
		self.add_route_for(vh)
		return vh
	end
	
	fun add_route_for(vh : VirtualHost)
	do
		var port_route : nullable HashMap[String, VirtualHost]
		port_route = router[vh.get_port]
		if port_route is null then
			port_route = new HashMap[String, VirtualHost]
		end
		for alias in vh.get_aliases do
			router[vh.get_port] = port_route
		end
	end

	fun route(port : Int, alias : String) : VirtualHost
	do
		var port_route : nullable HashMap[String, VirtualHost]
		port_route = router[port]
		if port_route is null then return default_host
		var routed_host : nullable VirtualHost = port_route[alias]
		if routed_host is null then
			return default_host
		else
			return routed_host.as(not null)
		end
	end

end
	

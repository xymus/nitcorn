module hostmanager

import virtualhost

class HostManager

    private var default_mimes : Mimes
	
	private var virtualhosts : Array[VirtualHost] = new Array[VirtualHost]

	type Router : HashMap[Int, HashMap[String, VirtualHost]]
	private var router : Router = new Router

	init
	do
	    self.default_mimes = get_new_default_mimes
	end
    
    private fun get_new_default_mimes : Mimes
    do
        var mimes : Mimes = new Mimes
        mimes.load_basic_mimes
        return mimes
    end
    
    fun get_default_mimes : Mimes do return default_mimes
    fun set_default_mimes(mimes : Mimes) do default_mimes = mimes end

    fun get_virtualhosts : ArrayIterator[VirtualHost] do return virtualhosts.iterator end

	fun addnew_virtualhost(name : String, port : Int, alias : String, root : String) : VirtualHost
	do
		var vh = new VirtualHost(name, port, alias, root, default_mimes)
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
			router[vh.get_port] = port_route
		end
		port_route[vh.get_alias] = vh
	end

	fun route(port : Int, alias : String) : nullable VirtualHost
	do
		var port_route : nullable HashMap[String, VirtualHost]
		port_route = router[port]
		if port_route is null then 
			return null
		else return port_route[alias]
	end

end
	
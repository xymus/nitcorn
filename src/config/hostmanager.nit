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
		return vh
	end
	
end
	
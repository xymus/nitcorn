module virtualhost

import mimes

class VirtualHost

	# id
    private var name : String
	
	private var port : Int
	
	# Domain name, i.e. www.domain.com
	private var alias : String

	# Root directory of content to be served
	private var root : String

	private var supported_mimes : Mimes

	init(name : String, port : Int, alias : String, root : String, supported_mimes : Mimes)
	do
	    self.name = name
		self.port = port
        self.alias = alias
        self.root = root
        self.supported_mimes = supported_mimes
	end

    fun get_name : String do return name
	fun get_port : Int do return port
	fun get_alias : String do return alias
	fun get_root : String do return root
	fun get_supported_mimes : Mimes do return supported_mimes

end

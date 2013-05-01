module virtualhost

import mimes

class VirtualHost

	# id
    private var name : String
	
	private var port : Int
	
	# Domain names, i.e. www.domain.com
	private var aliases : Array[String]

	# Root directory of content to be served
	private var root : String

	private var supported_mimes : Mimes

	init(name : String, port : Int, aliases : Array[String], root : String, supported_mimes : Mimes)
	do
	    self.name = name
		self.port = port
        self.aliases = aliases
        self.root = root
        self.supported_mimes = supported_mimes
	end

    fun get_name : String do return name
	fun get_port : Int do return port
	fun get_aliases : Array[String] do return aliases
	fun get_root : String do return root
	fun get_supported_mimes : Mimes do return supported_mimes

    fun set_root(new_root: String) do root = new_root

end

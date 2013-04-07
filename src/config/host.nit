module host

import mime

class Host

	private var name : String 
	private var root : String
	private var supported_mimes : Mimes

	init(name : String, root : String, supported_mimes : Mimes)
	do
		self.name = name
		self.root = root
        self.supported_mimes = supported_mimes
	end
	
	fun get_name : String do return name
	fun get_root : String do return root
	fun get_supported_mimes : Mimes do return supported_mimes

end

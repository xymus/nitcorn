module host

import urltree
import mime

class Host

	private var name : String 
	private var root : UrlTreeNode
	private var mimes : Mimes = new Mimes

	init(name : String)
	do
		self.name = name
		self.root = new UrlTreeNode.root
	end
	
	fun get_name : String do return name
	fun get_root : UrlTreeNode do return root
	fun get_mimes : Mimes do return mimes
	
	fun get_content(path : Array[String]) : nullable WebContent
	do
		var current : nullable UrlTreeNode = root
		
		for token in path do
			current = current.get_child(token)
			if current == null then do return null
		end
		
		return current.get_leaf
	end
	
	redef fun to_s : String
	do
		return name
	end
end

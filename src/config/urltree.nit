module urltree

# Content of a url node

class WebContent

	private var path : String
	private var mime : String

	init(path : String, mime : String)
	do
		self.path = path
		self.mime = mime
	end

	fun get_path : String do return path

	fun get_mime : String do return mime

	fun set_content(path : String, mime : String)
	do
		self.path = path
		self.mime = mime
	end
end

# A Node in the url tree

class UrlTreeNode

	private var name : String
	private var parent : nullable UrlTreeNode
	private var leaf : nullable WebContent
	private var childs : nullable HashMap[String, UrlTreeNode]

	init(name : String, parent : nullable UrlTreeNode,
	     leaf : nullable WebContent)
	do
		self.name = name
		self.parent = parent
		self.leaf = leaf
	end
	
	init root
	do
		self.name = "root"
	end
	
	fun get_name : String do return name
	fun get_parent : nullable UrlTreeNode do return parent
	fun get_leaf : nullable WebContent do return leaf
	
	fun get_childs : nullable HashMapIterator[String, UrlTreeNode]
	do
		if childs == null then return null
		return childs.iterator
	end

	fun add_child(child : UrlTreeNode)
	do
		if childs == null then childs = new HashMap[String, UrlTreeNode]
		childs[child.name] = child
	end

	fun get_child(name : String) : nullable UrlTreeNode
	do
		if childs == null then
			return null
		else if childs.keys.has(name) then
			return childs[name]
		else
			return null
		end
	end
end

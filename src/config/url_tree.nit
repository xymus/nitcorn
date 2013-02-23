module url_tree

# Content of a url node

class WebContent

	private var path : String
	private var mime_type : String

	init(path : String, mime_type : String)
	do
		self.path = path
		self.mime_type = mime_type
	end

	fun get_path : String do return path

	fun get_mime_type : String do return mime_type

	fun set_content(path : String, mime_type : String)
	do
		self.path = path
		self.mime_type = mime_type
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

	fun add_child(child : UrlTreeNode)
	do
		if childs == null then childs = new HashMap[String, UrlTreeNode]
		childs[child.name] = child
	end

	fun get_child(name : String) : nullable UrlTreeNode
	do
		if childs == null then
			return null
		else
			return childs[name]
		end
	end
end

# Tests

var wc = new WebContent("index.html","text/html")

var root = new UrlTreeNode("", null, wc)
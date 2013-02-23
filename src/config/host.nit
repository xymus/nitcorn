module host

class Host

	private var url_tree_root : UrlTreeNode

	init(url_tree_root : UrlTreeNode)
	do
		self.url_tree_root = url_tree_root
	end
end
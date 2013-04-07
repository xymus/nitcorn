module ip

class Ip

	private var parts : Array[Int]

	init(parts : Array[Int])
	do
		self.parts = parts
	end

	fun get_part(i : Int) : Int
	do
		return parts[i]
	end
	
	redef fun hash : Int
	do
		var h = 1
		
		for i in parts do
			h = 31 * h + i
		end
		
		return h
	end
	
	redef fun to_s : String
	do
		return parts.join(".")
	end
end

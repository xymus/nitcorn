module ip

class Ip

	private var parts : Array[Int]

	init(p : Array[Int])
	do
		parts = p
	end

	fun get_p(i : Int) : Int
	do
		return parts[i]
	end
end

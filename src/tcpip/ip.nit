module ip

class Ip

	private var parts : Array[Int]

	init(p : Array[Int])
	do
		parts = p
	end

end

# Tests

var ip = new Ip([127, 0, 0, 1])
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

# Tests

var ip = new Ip([127, 0, 0, 1])
print "ip: {ip.get_p(0)}.{ip.get_p(1)}.{ip.get_p(2)}.{ip.get_p(3)}"
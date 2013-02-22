module config

# Server instance configuration

class Config

	var init_time : Int
	var name : String

    init(n : String)
    do
    	init_time = get_time
    	name = n
    end

end

# Tests

var config = new Config("test_config")

print "init time: {config.init_time}"
print "instance name: {config.name}"
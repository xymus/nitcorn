module config

# Server instance configuration

class Config

	var init_time : Int

    init do
    	init_time = get_time
    end

end

# Tests

var config = new Config

print config.init_time
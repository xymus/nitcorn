module config

# Server instance configuration

class Config

	private var name : String

	private var init_time : Int

	private var log_error_path : String = "log/error.log"
	private var log_access_path : String = "log/access.log"
	private var log_info_path : String = "log/info.log"
	private var log_debug_path : String = "log/debug.log"

    init(n : String)
    do
    	name = n
    	init_time = get_time
    end

    fun get_name : String do return name

    fun get_init_time : Int do return init_time

    fun get_log_error_path : String return log_error_path
    fun get_log_access_path : String return log_access_path
    fun get_log_info_path : String return log_info_path
    fun get_log_debug_path : String return log_debug_path

end

# Tests

var config = new Config("test_config")

print "init time: {config.init_time}"
print "instance name: {config.name}"
module config

import ip
import host
import virtualhost
import hosts_manager

# Server instance configuration

class Config

	private var name : String

	private var init_time : Int

	private var log_error_path : String = "log/error.log"
	private var log_access_path : String = "log/access.log"
	private var log_info_path : String = "log/info.log"
	private var log_debug_path : String = "log/debug.log"
	
	private var hostsmanager : HostsManager = new HostsManager

    init(name : String)
    do
    	self.name = name
    	self.init_time = get_time
    end

    fun get_name : String do return name

    fun get_init_time : Int do return init_time
    
    fun get_hostsmanager : HostsManager do return hostsmanager

    fun get_log_error_path : String do return log_error_path
    fun set_log_error_path(path : String) do log_error_path = path end
    fun get_log_access_path : String do return log_access_path
    fun set_log_access_path(path : String) do log_access_path = path end
    fun get_log_info_path : String do return log_info_path
    fun set_log_info_path(path : String) do log_info_path = path end 
    fun get_log_debug_path : String do return log_debug_path
    fun set_log_debug_path(path : String) do log_debug_path = path end

    redef fun to_s : String
    do
        var base = "name:{name} init_t:{init_time}"
        var logs = "Logs \{ {log_error_path}, {log_access_path}, {log_info_path}, {log_debug_path} \}"
        return "Config \{\n{base}\n{logs}\n\}"
    end
end

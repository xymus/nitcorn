module config

import hostmanager
import logmanager

# Server instance configuration

class Config

	private var name : String
	private var init_time : Int
	private var accepted_methods: Array[String] = ["GET"]

	private var logmanager : LogManager = new LogManager
	private var hostmanager : HostManager = new HostManager

    private var config_db_path : String = "config.sqlite"
    private var config_script_path : String = "../../sql/config.sql"
    
    init(name : String)
    do
    	self.name = name
    	self.init_time = get_time
    end

    fun get_accepted_methods : Array[String] do return accepted_methods

    fun get_name : String do return name

    fun get_init_time : Int do return init_time
    
    fun get_logmanager : LogManager do return logmanager
    fun get_hostsmanager : HostManager do return hostmanager

end

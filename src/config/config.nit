module config

import hostmanager
import logmanager

# Server instance configuration

class Config

	private var name : String
	private var init_time : Int

	private var logmanager : LogManager = new LogManager
	private var hostmanager : HostManager = new HostManager

    init(name : String)
    do
    	self.name = name
    	self.init_time = get_time
    end

    fun get_name : String do return name

    fun get_init_time : Int do return init_time
    
    fun get_logmanager : LogManager do return logmanager
    fun get_hostsmanager : HostManager do return hostmanager

end

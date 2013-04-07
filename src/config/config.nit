module config

import hostmanager
import logmanager
import sqlite3

# Server instance configuration

class Config

	private var name : String
	private var init_time : Int

	private var logmanager : LogManager = new LogManager
	private var hostmanager : HostManager = new HostManager

    private var config_db_path : String = "config.sqlite"
    private var config_script_path : String = "../../sql/config.sql"
    
    init(name : String)
    do
    	self.name = name
    	self.init_time = get_time
    end

    fun get_name : String do return name

    fun get_init_time : Int do return init_time
    
    fun get_logmanager : LogManager do return logmanager
    fun get_hostsmanager : HostManager do return hostmanager

    fun save_config
    do
        if not config_db_path.file_exists then 
            create_db
        end
        do_save_config
    end

    fun create_db
    do
        # hack for prototype only... TODO eventually
        var cmd : String = "sqlite3 {config_db_path} < {config_script_path}"
        sys.system(cmd)
    end

    fun do_save_config
    do
        var db: Sqlite3 = new Sqlite3

        #Log path save
        var log: LogManager = get_logmanager
        var req : String = "INSERT INTO LogPaths VALUES(NULL, '{log.get_e_path}', '{log.get_a_path}', '{log.get_i_path}', '{log.get_d_path}', '{log.get_v_path}', '{log.get_w_path}', '{log.get_wtf_path}');"
        db.open(config_db_path)
        db.exec(req)

        #Config save
        var log_id: Int = db.last_insert_rowid
        req = "INSERT INTO Config VALUES(NULL, '{get_name}', '{log_id}')"
        db.exec(req)

        #Host save
        var host_man : HostManager = get_hostsmanager
        var iterator: HashMapIterator[String, Host] = host_man.get_hosts
        while iterator.is_ok do
            var host: Host = iterator.item
            req = "INSERT INTO Host VALUES(NULL, '{host.get_name}', '{host.get_root}')"
            db.exec(req)
            print "fuck"
            iterator.next
        end

        db.close
    end
    

end

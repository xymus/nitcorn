module configpersistance

import config
import sqlite3


redef class Config
    private var config_db_path : String = "config.sqlite"
    private var config_script_path : String = "../../sql/config.sql"

    fun save_config
    do
        if not config_db_path.file_exists then 
            create_db
        end
        do_save_config

    end
    
    fun create_db
    do
        # hack for prototype only... TODO enventually
        var proc : Process = new Process("sqlite3 {config_db_path} < {config_script_path}", "")
        proc.wait
        #        sys.system("sqlite3 {config_db_path} < {config_script_path}")
    end

    fun do_save_config
    do
        var db: Sqlite3 = new Sqlite3
        var log: LogManager = get_logmanager
        var req : String = "INSERT INTO LogPaths VALUES('{log.get_e_path}', '{log.get_a_path}', '{log.get_i_path}', '{log.get_d_path}', '{log.get_v_path}', '{log.get_w_path}', '{log.get_wtf_path}');"
        print req
        db.open(config_db_path)
        db.exec(req)
        print db.get_error_str
        db.close
                #        var req : String = "INSERT INTO Config VALUES("
    end

end

var config: Config = new Config("")
config.save_config

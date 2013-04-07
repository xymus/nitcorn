module configpersistance

import config


redef class Config
    private var config_db_path : String = "config.db"
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
        sys.system("sqlite3 {config_db_path} < {config_script_path}")
    end

    fun do_save_config
    do

    end

end

var config: Config = new Config("")
config.save_config

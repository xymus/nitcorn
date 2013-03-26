module logmanager

class LogManager

	private var error_path : String = "log/error.log"
	private var access_path : String = "log/access.log"
	private var info_path : String = "log/info.log"
	private var debug_path : String = "log/debug.log"
	private var verbose_path : String = "log/verbose.log"
	private var warning_path : String = "log/warning.log"
	private var wtf_path : String = "log/wtf.log"

    fun get_e_path : String do return error_path
    fun set_e_path(path : String) do error_path = path end
    
    fun get_a_path : String do return access_path
    fun set_a_path(path : String) do access_path = path end
    
    fun get_i_path : String do return info_path
    fun set_i_path(path : String) do info_path = path end 
    
    fun get_d_path : String do return debug_path
    fun set_d_path(path : String) do debug_path = path end
    
    fun get_v_path : String do return verbose_path
    fun set_v_path(path : String) do verbose_path = path end
    
    fun get_w_path : String do return warning_path
    fun set_w_path(path : String) do warning_path = path end
    
    fun get_wtf_path : String do return wtf_path
    fun set_wtf_path(path : String) do wtf_path = path end

end

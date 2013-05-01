module logmanager
import log

class LogManager

	private var error_logger: Log
	private var access_logger: Log

    init(error_path:String, access_path: String) do
        error_logger = new Log(error_path)
        access_logger = new Log(access_path)
    end

    fun log(tag: String, message: String) do
        access_logger.debug(0, message, tag)
    end

    fun error(message: String) do
        error_logger.error(0, message)
    end


end

module mime

class Mimes

    private var mimes : HashMap[String, String] = new HashMap[String, String]
    
    fun set_mime(ext : String, mime : String)
    do
    	mimes[ext] = mime
    end

    fun get_mime(ext : String) : String
    do
        # Because HashMap[k:Key] does not support unexisting keys
        if not mimes.keys.has(ext) then
            return mimes[""]
        else
            return mimes[ext]
        end
    end
    
    fun load_basic_memes
    do
        mimes["html"]       = "text/html"
        mimes["htm"]        = "text/html"
        mimes["shtml"]      = "text/html"
        mimes["css"]        = "text/css"
        mimes["xml"]        = "text/xml"
        mimes["rss"]        = "text/xml"
        mimes["gif"]        = "image/gif"
        mimes["jpg"]        = "image/jpeg"
        mimes["jpeg"]       = "image/jpeg"
        mimes["js"]         = "application/x-javascript"
        mimes["txt"]        = "text/plain"
        mimes["htc"]        = "text/x-component"
        mimes["mml"]        = "text/mathml"
        mimes["png"]        = "image/png"
        mimes["ico"]        = "image/x-icon"
        mimes["jng"]        = "image/x-jng"
        mimes["wbmp"]       = "image/vnd.wap.wbmp"
        mimes["jar"]        = "application/java-archive"
        mimes["war"]        = "application/java-archive"
        mimes["ear"]        = "application/java-archive"
        mimes["hqx"]        = "application/mac-binhex40"
        mimes["pdf"]        = "application/pdf"
        mimes["cco"]        = "application/x-cocoa"
        mimes["jardiff"]    = "application/x-java-archive-diff"
        mimes["jnlp"]       = "application/x-java-jnlp-file"
        mimes["run"]        = "application/x-makeself"
        mimes["pl"]         = "application/x-perl"
        mimes["pm"]         = "application/x-perl"
        mimes["pdb"]        = "application/x-pilot"
        mimes["prc"]        = "application/x-pilot"
        mimes["rar"]        = "application/x-rar-compressed"  
        mimes["rpm"]        = "application/x-redhat-package-manager"
        mimes["sea"]        = "application/x-sea"
        mimes["swf"]        = "application/x-shockwave-flash"
        mimes["sit"]        = "application/x-stuffit"
        mimes["tcl"]        = "application/x-tcl"
        mimes["tk"]         = "application/x-tcl"
        mimes["der"]        = "application/x-x509-ca-cert"
        mimes["pem"]        = "application/x-x509-ca-cert"
        mimes["crt"]        = "application/x-x509-ca-cert"
        mimes["xpi"]        = "application/x-xpinstall" 
        mimes["zip"]        = "application/zip"
        mimes["deb"]        = "application/octet-stream"
        mimes["bin"]        = "application/octet-stream"
        mimes["exe"]        = "application/octet-stream"
        mimes["dll"]        = "application/octet-stream"
        mimes["dmg"]        = "application/octet-stream"
        mimes["eot"]        = "application/octet-stream"
        mimes["iso"]        = "application/octet-stream"
        mimes["img"]        = "application/octet-stream"
        mimes["msi"]        = "application/octet-stream"
        mimes["msp"]        = "application/octet-stream"
        mimes["msm"]        = "application/octet-stream"
        mimes["mp3"]        = "audio/mpeg"
        mimes["ra"]         = "audio/x-realaudio"
        mimes["mpeg"]       = "video/mpeg"
        mimes["mpg"]        = "video/mpeg"
        mimes["mov"]        = "video/quicktime"
        mimes["flv"]        = "video/x-flv"
        mimes["avi"]        = "video/x-msvideo"
        mimes["wmv"]        = "video/x-ms-wmv"
        mimes["asx"]        = "video/x-ms-asf"
        mimes["asf"]        = "video/x-ms-asf"
        mimes["mng"]        = "video/x-mng"
    end
end

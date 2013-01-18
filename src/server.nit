import serialize
import sockets

class Request
    var http_version : nullable Int
    var method : nullable Int
    var uri : nullable String
    var host : nullable String
    var headers : nullable HashMap[String, String]
    init do end
end

class StreamBuffer
    var conn : CommunicationSocket

    fun readline : String do
        var b = new Buffer
        var str : nullable String
        print conn.errno
        var i = 0
        loop
            i += 1
            if i > 10 then break
            if conn.errno != 0 then
                print conn.errno
                continue
            end
            str = conn.read
            var nstr = str
            if nstr != null then
                if nstr[nstr.length-1] == "\n" then
                    break
                end
            end
        end

        return b.to_s
    end
end

class HttpClient
    var connection : CommunicationSocket
    var stream : StreamBuffer
    var request: Request

    init(s : CommunicationSocket) do
        connection = s
        stream = new StreamBuffer(s)
        request = new Request
    end

    fun read_request do
        var input = stream.readline
        print input
    end

end

var clients = new List[HttpClient]
var listening_socket = new ListeningSocket.bind_to("localhost", 12345)

loop
    var comm_socket : nullable CommunicationSocket = listening_socket.accept
    
    if comm_socket != null then
        var new_client = new HttpClient(comm_socket)
        clients.add(new_client)
        print "new client"
    end

    for client in clients do
        client.read_request
        client.connection.close
        clients.remove(client)
        print "removing client"
    end
end

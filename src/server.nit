import event

class HttpReactor
super Reactor
    redef fun read(line : String) do
        print line
        self.write("got ya\n")
    end
end

class HttpReactorFactory
super ReactorFactory
    redef fun make_reactor : Reactor do
        print "created http reactor"
        return new HttpReactor
    end
end


var e : EventBase = new EventBase.create_base
var listener = new ConnectionListener.bind_to(e, "localhost", 12345)

listener.set_reactor_factory(new HttpReactorFactory)

print "running"
e.dispatch

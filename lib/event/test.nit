import event
redef class ConnectionListener
        redef fun read_callback do
                print "Hello"
        end
end

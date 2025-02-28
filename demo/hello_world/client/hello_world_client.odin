package demo

import "core:fmt"
import "core:time"
import zmq "../../../"

main :: proc() {
    zmq_context := zmq.ctx_new()
    zmq_requester := zmq.socket(zmq_context, zmq.ZMQ_REQ)
    zmq.connect(zmq_requester, "tcp://localhost:5555")
    nbr := 0
    for {
        fmt.println("Sending Hello ",nbr)
        zmq.send(zmq_requester, "Hello", 5, 0)
        buffer : [10]u8
        zmq.recv(zmq_requester,&buffer[0],10,0)
        fmt.println("Received: " ,transmute(string)(buffer[:10]))
        time.sleep(1000)
        nbr += 1
    }
    zmq.close(zmq_requester)
    zmq.ctx_destroy(zmq_context)
}
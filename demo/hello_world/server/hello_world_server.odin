package demo

import "core:fmt"
import "core:time"
import zmq "../../../"

main :: proc() {
    zmq_context := zmq.ctx_new()
    zmq_responder := zmq.socket(zmq_context, zmq.ZMQ_REP)
    rc := zmq.bind(zmq_responder, "tcp://*:5555")
    if rc != 0 {
        fmt.println("Error binding to socket")
        return
    }
    for {
        buffer : [10]u8
        zmq.recv(zmq_responder,&buffer[0],10,0)
        fmt.println("Received: " ,transmute(string)(buffer[:10]))
        time.sleep(10)
        zmq.send(zmq_responder, "World", 5, 0)
    }
}
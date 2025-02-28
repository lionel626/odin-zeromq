package demo

import zmq "../../../"
import "core:fmt"
import "core:math/rand"

main :: proc() {
    zmq_context := zmq.ctx_new()
    publisher := zmq.socket(zmq_context, zmq.ZMQ_PUB)
    rc := zmq.bind(publisher, "tcp://*:5556")
    if rc != 0 {
        fmt.println("Error binding to socket")
        return
    }
    for {
        zipcode, temperature, relhumidity : i32
        zipcode = i32(rand.uint32() % 100000)
        temperature = i32(rand.uint32() % 215) - 80
        relhumidity = i32(rand.uint32() % 50) + 10

        update : [20]u8
        fmt.bprintf(update[:], "%05d %d %d", zipcode, temperature, relhumidity)
        if zipcode == 10001 {

            fmt.printfln("Sending: %s", update[:])
        }
        zmq.send(publisher, transmute(cstring)(&update[0]), 20, 0)
    }
    zmq.close(publisher)
    zmq.ctx_destroy(zmq_context)

}
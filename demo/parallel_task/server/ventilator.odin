package demo

import zmq "../../../"
import "core:fmt"
import "core:math/rand"
import "core:strings"
import "core:strconv"
import "core:os"


main :: proc() {
    zmq_context := zmq.ctx_new()

    //  Socket to send messages on
    sender := zmq.socket(zmq_context, zmq.ZMQ_PUSH)
    zmq.bind(sender, "tcp://*:5557")

    //  Socket to send start of batch message on
    sink := zmq.socket(zmq_context, zmq.ZMQ_PUSH)
    zmq.connect(sink, "tcp://localhost:5558")

    fmt.print("Press Enter when the workers are ready: ")
    buff :[1]u8
    nbread, err := os.read(os.stdin, buff[:])
    if err != nil {
        fmt.println("Error reading from stdin")
        return
    }
    fmt.println("Sending tasks to workers...")
    //  The first message is "0" and signals start of batch
    zmq.send(sink, "0", 1, 0)

    //  Initialize random number generator

    //  Send 100 tasks
    total_msec : i32
    for task_nbr := 0; task_nbr < 100; task_nbr+=1 {
        workload := rand.uint32()%100 + 1
        total_msec += i32(workload)
        conv_buff : [4]u8
        s_string := strconv.itoa(conv_buff[:],int(workload))

        zmq.send(sender, strings.unsafe_string_to_cstring(s_string), i32(len(s_string)), 0)
    }
    fmt.printfln("Total expected cost: %d msec", total_msec)

    zmq.close(sink)
    zmq.close(sender)
    zmq.ctx_destroy(zmq_context)
}
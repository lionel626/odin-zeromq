package demo

import zmq "../../../"
import "core:fmt"
import "core:math/rand"
import "core:strings"
import "core:strconv"
import "core:os"
import "core:time"

/*
    //  Task worker
//  Connects PULL socket to tcp://localhost:5557
//  Collects workloads from ventilator via that socket
//  Connects PUSH socket to tcp://localhost:5558
//  Sends results to sink via that socket

#include "zhelpers.h"

int main (void) 
{
    //  Socket to receive messages on
    void *context = zmq_ctx_new ();
    void *receiver = zmq_socket (context, ZMQ_PULL);
    zmq_connect (receiver, "tcp://localhost:5557");

    //  Socket to send messages to
    void *sender = zmq_socket (context, ZMQ_PUSH);
    zmq_connect (sender, "tcp://localhost:5558");

    //  Process tasks forever
    while (1) {
        char *string = s_recv (receiver);
        printf ("%s.", string);     //  Show progress
        fflush (stdout);
        s_sleep (atoi (string));    //  Do the work
        free (string);
        s_send (sender, "");        //  Send results to sink
    }
    zmq_close (receiver);
    zmq_close (sender);
    zmq_ctx_destroy (context);
    return 0;
}
*/

main :: proc() {
    //  Socket to receive messages on
    zmq_context := zmq.ctx_new()
    receiver := zmq.socket(zmq_context, zmq.ZMQ_PULL)
    zmq.connect(receiver, "tcp://localhost:5557")

    //  Socket to send messages to
    sender := zmq.socket(zmq_context, zmq.ZMQ_PUSH)
    zmq.connect(sender, "tcp://localhost:5558")

    //  Process tasks forever
    for {
        r_string : [10]u8
        zmq.recv(receiver, &r_string[0], 10, 0)
        fmt.printfln("%s.", r_string)     //  Show progress
        time.sleep(time.Duration(strconv.atoi(string(r_string[:]))))    //  Do the work
        zmq.send(sender, "", 0, 0)        //  Send results to sink
    }
    zmq.close(receiver)
    zmq.close(sender)
    zmq.ctx_destroy(zmq_context)
}
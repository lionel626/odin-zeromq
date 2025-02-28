package demo

import zmq "../../../"
import "core:fmt"
import "core:math/rand"
import "core:strings"
import "core:strconv"
import "core:os"
import "core:time"


/*
//  Task sink
//  Binds PULL socket to tcp://localhost:5558
//  Collects results from workers via that socket

#include "zhelpers.h"

int main (void) 
{
    //  Prepare our context and socket
    void *context = zmq_ctx_new ();
    void *receiver = zmq_socket (context, ZMQ_PULL);
    zmq_bind (receiver, "tcp://*:5558");

    //  Wait for start of batch
    char *string = s_recv (receiver);
    free (string);

    //  Start our clock now
    int64_t start_time = s_clock ();

    //  Process 100 confirmations
    int task_nbr;
    for (task_nbr = 0; task_nbr < 100; task_nbr++) {
        char *string = s_recv (receiver);
        free (string);
        if (task_nbr % 10 == 0)
            printf (":");
        else
            printf (".");
        fflush (stdout);
    }
    //  Calculate and report duration of batch
    printf ("Total elapsed time: %d msec\n", 
        (int) (s_clock () - start_time));

    zmq_close (receiver);
    zmq_ctx_destroy (context);
    return 0;
}
*/
*/
main :: proc() {
    // Prepare our context and socket
    zmq_context := zmq.ctx_new()
    receiver := zmq.socket(zmq_context, zmq.ZMQ_PULL)
    zmq.bind(receiver, "tcp://*:5558")

    // Wait for start of batch
    r_string : [1]u8
    zmq.recv(receiver, &r_string[0], 1, 0)

    // Start our clock now
    start_time := time.now()._nsec

    // Process 100 confirmations
    for task_nbr := 0; task_nbr < 100; task_nbr+=1 {
        r_string : [10]u8
        zmq.recv(receiver, &r_string[0], 10, 0)
        if task_nbr % 10 == 0 {
            fmt.print(":")
        } else {
            fmt.print(".")
        }
    }
    // Calculate and report duration of batch

    fmt.printfln("Total elapsed time: %d msec", time.now()._nsec - start_time)

    zmq.close(receiver)
    zmq.ctx_destroy(zmq_context)
}
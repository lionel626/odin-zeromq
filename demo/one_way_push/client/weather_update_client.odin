package demo

import zmq "../../../"
import "core:fmt"
import "core:math/rand"
import "core:strings"
import "core:strconv"

/*
//  Weather update client
//  Connects SUB socket to tcp://localhost:5556
//  Collects weather updates and finds avg temp in zipcode

#include "zhelpers.h"

int main (int argc, char *argv [])
{
    //  Socket to talk to server
    printf ("Collecting updates from weather server...\n");
    void *context = zmq_ctx_new ();
    void *subscriber = zmq_socket (context, ZMQ_SUB);
    int rc = zmq_connect (subscriber, "tcp://localhost:5556");
    assert (rc == 0);

    //  Subscribe to zipcode, default is NYC, 10001
    const char *filter = (argc > 1)? argv [1]: "10001 ";
    rc = zmq_setsockopt (subscriber, ZMQ_SUBSCRIBE,
                         filter, strlen (filter));
    assert (rc == 0);

    //  Process 100 updates
    int update_nbr;
    long total_temp = 0;
    for (update_nbr = 0; update_nbr < 100; update_nbr++) {
        char *string = s_recv (subscriber);

        int zipcode, temperature, relhumidity;
        sscanf (string, "%d %d %d",
            &zipcode, &temperature, &relhumidity);
        total_temp += temperature;
        free (string);
    }
    printf ("Average temperature for zipcode '%s' was %dF\n",
        filter, (int) (total_temp / update_nbr));

    zmq_close (subscriber);
    zmq_ctx_destroy (context);
    return 0;
}
*/

main :: proc() {
    fmt.printfln("Collecting updates from weather server...")
    zmq_context := zmq.ctx_new()
    subscriber := zmq.socket(zmq_context, zmq.ZMQ_SUB)
    rc := zmq.connect(subscriber, "tcp://localhost:5556")
    if rc != 0 {
        fmt.println("Error connecting to socket")
        return
    }
    filter := "10001 "
    rc = zmq.setsockopt(subscriber, zmq.ZMQ_SUBSCRIBE, rawptr(strings.unsafe_string_to_cstring(filter)), len(filter))
    if rc != 0 {
        fmt.println("Error setting socket option")
        return
    }
    update_nbr := 0
    total_temp := 0
    for update_nbr < 100 {
        buffer : [20]u8
        zmq.recv(subscriber, &buffer[0], 20, 0)
        recv_string := transmute(string)(buffer[:20])
        fmt.println("received: ", recv_string)
        total_temp += strconv.atoi(strings.split(recv_string, " ")[1])
        update_nbr += 1
    }
    fmt.printfln("Average temperature for zipcode '%s' was %dF", filter, total_temp / update_nbr)
    zmq.close(subscriber)
    zmq.ctx_destroy(zmq_context)

}
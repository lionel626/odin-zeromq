package demo

import zmq "../../"
import "core:fmt"

main :: proc() {
    major, minor, patch : i32
    zmq.version(&major, &minor, &patch)
    fmt.println("Current 0MQ version is ", major, ".", minor, ".", patch)
}
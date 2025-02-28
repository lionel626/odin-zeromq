package zmq;

/*
    ZeroMQ bindings for Odin using czmq
*/

import "core:c"

foreign import zmq "system:zmq"

/*  Version macros for compile-time API version detection                     */
ZMQ_VERSION_MAJOR :: 4
ZMQ_VERSION_MINOR :: 3
ZMQ_VERSION_PATCH :: 6

/******************************************************************************/
/*  0MQ infrastructure (a.k.a. context) initialisation & termination.         */
/******************************************************************************/

/*  Context options                                                           */
ZMQ_IO_THREADS :: 1
ZMQ_MAX_SOCKETS :: 2
ZMQ_SOCKET_LIMIT :: 3
ZMQ_THREAD_PRIORITY :: 3
ZMQ_THREAD_SCHED_POLICY :: 4
ZMQ_MAX_MSGSZ :: 5
ZMQ_MSG_T_SIZE :: 6
ZMQ_THREAD_AFFINITY_CPU_ADD :: 7
ZMQ_THREAD_AFFINITY_CPU_REMOVE :: 8
ZMQ_THREAD_NAME_PREFIX :: 9

/*  Default for new contexts                                                  */
ZMQ_IO_THREADS_DFLT :: 1
ZMQ_MAX_SOCKETS_DFLT :: 1023
ZMQ_THREAD_PRIORITY_DFLT :: -1
ZMQ_THREAD_SCHED_POLICY_DFLT :: -1

@(default_calling_convention="c", link_prefix="zmq_")
foreign zmq {
    ctx_new :: proc() -> Context ---
    ctx_term :: proc(ctx: Context) -> i32 ---
    ctx_shutdown :: proc(ctx: Context) -> i32 ---
    ctx_set :: proc(ctx: Context, option: i32, optval: i32) -> i32 ---
    ctx_get :: proc(ctx: Context, option: i32) -> i32 ---
    ctx_destroy :: proc(ctx: Context) -> i32 ---
}

/******************************************************************************/
/*  0MQ message definition.                                                   */
/******************************************************************************/

Message :: struct {
    _ : [64]c.char
}

@(default_calling_convention="c", link_prefix="zmq_")
foreign zmq {
    msg_init :: proc(msg: ^Message) -> i32 ---
    msg_init_size :: proc(msg: ^Message, size: c.size_t) -> i32 ---
    msg_init_data :: proc(msg: ^Message, data: cstring, size: c.size_t) -> i32 ---
    msg_close :: proc(msg: ^Message) -> i32 ---
    msg_data :: proc(msg: ^Message) -> cstring ---
    msg_size :: proc(msg: ^Message) -> c.size_t ---
    msg_send :: proc(socket: rawptr, msg: ^Message, flags: i32) -> i32 ---
    msg_recv :: proc(socket: rawptr, msg: ^Message, flags: i32) -> i32 ---
    msg_more :: proc(msg: ^Message) -> i32 ---
    msg_get :: proc(msg: ^Message, option: i32, optval: rawptr, optlen: ^c.size_t) -> i32 ---
    msg_set :: proc(msg: ^Message, option: i32, optval: rawptr, optlen: c.size_t) -> i32 ---
    msg_copy :: proc(dest: ^Message, src: ^Message) -> i32 ---
    msg_gets :: proc(msg: ^Message, property: cstring) -> cstring ---
}

/******************************************************************************/
/*  0MQ socket definition.                                                    */
/******************************************************************************/

/*  Socket types.                                                             */
ZMQ_PAIR :: 0
ZMQ_PUB :: 1
ZMQ_SUB :: 2
ZMQ_REQ :: 3
ZMQ_REP :: 4
ZMQ_DEALER :: 5
ZMQ_ROUTER :: 6
ZMQ_PULL :: 7
ZMQ_PUSH :: 8
ZMQ_XPUB :: 9
ZMQ_XSUB :: 10
ZMQ_STREAM :: 11

/*  Socket options.                                                           */
ZMQ_AFFINITY :: 4
ZMQ_ROUTING_ID :: 5
ZMQ_SUBSCRIBE :: 6
ZMQ_UNSUBSCRIBE :: 7
ZMQ_RATE :: 8
ZMQ_RECOVERY_IVL :: 9
ZMQ_SNDBUF :: 11
ZMQ_RCVBUF :: 12
ZMQ_RCVMORE :: 13
ZMQ_FD :: 14
ZMQ_EVENTS :: 15
ZMQ_TYPE :: 16
ZMQ_LINGER :: 17
ZMQ_RECONNECT_IVL :: 18
ZMQ_BACKLOG :: 19
ZMQ_RECONNECT_IVL_MAX :: 21
ZMQ_MAXMSGSIZE :: 22
ZMQ_SNDHWM :: 23
ZMQ_RCVHWM :: 24
ZMQ_MULTICAST_HOPS :: 25
ZMQ_RCVTIMEO :: 27
ZMQ_SNDTIMEO :: 28
ZMQ_LAST_ENDPOINT :: 32
ZMQ_ROUTER_MANDATORY :: 33
ZMQ_TCP_KEEPALIVE :: 34
ZMQ_TCP_KEEPALIVE_CNT :: 35
ZMQ_TCP_KEEPALIVE_IDLE :: 36
ZMQ_TCP_KEEPALIVE_INTVL :: 37
ZMQ_IMMEDIATE :: 39
ZMQ_XPUB_VERBOSE :: 40
ZMQ_ROUTER_RAW :: 41
ZMQ_IPV6 :: 42
ZMQ_MECHANISM :: 43
ZMQ_PLAIN_SERVER :: 44
ZMQ_PLAIN_USERNAME :: 45
ZMQ_PLAIN_PASSWORD :: 46
ZMQ_CURVE_SERVER :: 47
ZMQ_CURVE_PUBLICKEY :: 48
ZMQ_CURVE_SECRETKEY :: 49
ZMQ_CURVE_SERVERKEY :: 50
ZMQ_PROBE_ROUTER :: 51
ZMQ_REQ_CORRELATE :: 52
ZMQ_REQ_RELAXED :: 53
ZMQ_CONFLATE :: 54
ZMQ_ZAP_DOMAIN :: 55
ZMQ_ROUTER_HANDOVER :: 56
ZMQ_TOS :: 57
ZMQ_CONNECT_ROUTING_ID :: 61
ZMQ_GSSAPI_SERVER :: 62
ZMQ_GSSAPI_PRINCIPAL :: 63
ZMQ_GSSAPI_SERVICE_PRINCIPAL :: 64
ZMQ_GSSAPI_PLAINTEXT :: 65
ZMQ_HANDSHAKE_IVL :: 66
ZMQ_SOCKS_PROXY :: 68
ZMQ_XPUB_NODROP :: 69
ZMQ_BLOCKY :: 70
ZMQ_XPUB_MANUAL :: 71
ZMQ_XPUB_WELCOME_MSG :: 72
ZMQ_STREAM_NOTIFY :: 73
ZMQ_INVERT_MATCHING :: 74
ZMQ_HEARTBEAT_IVL :: 75
ZMQ_HEARTBEAT_TTL :: 76
ZMQ_HEARTBEAT_TIMEOUT :: 77
ZMQ_XPUB_VERBOSER :: 78
ZMQ_CONNECT_TIMEOUT :: 79
ZMQ_TCP_MAXRT :: 80
ZMQ_THREAD_SAFE :: 81
ZMQ_MULTICAST_MAXTPDU :: 84
ZMQ_VMCI_BUFFER_SIZE :: 85
ZMQ_VMCI_BUFFER_MIN_SIZE :: 86
ZMQ_VMCI_BUFFER_MAX_SIZE :: 87
ZMQ_VMCI_CONNECT_TIMEOUT :: 88
ZMQ_USE_FD :: 89
ZMQ_GSSAPI_PRINCIPAL_NAMETYPE :: 90
ZMQ_GSSAPI_SERVICE_PRINCIPAL_NAMETYPE :: 91
ZMQ_BINDTODEVICE :: 92

/*  Message options                                                           */
ZMQ_MORE :: 1
ZMQ_SHARED :: 3

/*  Send/recv options.                                                        */
ZMQ_DONTWAIT :: 1
ZMQ_SNDMORE :: 2

/*  Security mechanisms                                                       */
ZMQ_NULL :: 0
ZMQ_PLAIN :: 1
ZMQ_CURVE :: 2
ZMQ_GSSAPI :: 3

/*  RADIO-DISH protocol                                                       */
ZMQ_GROUP_MAX_LENGTH :: 255

/******************************************************************************/
/*  GSSAPI definitions                                                        */
/******************************************************************************/

/*  GSSAPI principal name types                                               */
ZMQ_GSSAPI_NT_HOSTBASED :: 0
ZMQ_GSSAPI_NT_USER_NAME :: 1
ZMQ_GSSAPI_NT_KRB5_PRINCIPAL :: 2

/******************************************************************************/
/*  0MQ socket events and monitoring                                          */
/******************************************************************************/

/*  Socket transport events (TCP, IPC and TIPC only)                          */

ZMQ_EVENT_CONNECTED :: 0x0001
ZMQ_EVENT_CONNECT_DELAYED :: 0x0002
ZMQ_EVENT_CONNECT_RETRIED :: 0x0004
ZMQ_EVENT_LISTENING :: 0x0008
ZMQ_EVENT_BIND_FAILED :: 0x0010
ZMQ_EVENT_ACCEPTED :: 0x0020
ZMQ_EVENT_ACCEPT_FAILED :: 0x0040
ZMQ_EVENT_CLOSED :: 0x0080
ZMQ_EVENT_CLOSE_FAILED :: 0x0100
ZMQ_EVENT_DISCONNECTED :: 0x0200
ZMQ_EVENT_MONITOR_STOPPED :: 0x0400
ZMQ_EVENT_ALL :: 0xFFFF
/*  Unspecified system errors during handshake. Event value is an errno.      */
ZMQ_EVENT_HANDSHAKE_FAILED_NO_DETAIL :: 0x0800
/*  Handshake complete successfully with successful authentication (if        *
 *  enabled). Event value is unused.                                          */
ZMQ_EVENT_HANDSHAKE_SUCCEEDED :: 0x1000
/*  Protocol errors between ZMTP peers or between server and ZAP handler.     *
 *  Event value is one of ZMQ_PROTOCOL_ERROR_*                                */
ZMQ_EVENT_HANDSHAKE_FAILED_PROTOCOL :: 0x2000
/*  Failed authentication requests. Event value is the numeric ZAP status     *
 *  code, i.e. 300, 400 or 500.                                               */
ZMQ_EVENT_HANDSHAKE_FAILED_AUTH :: 0x4000
ZMQ_PROTOCOL_ERROR_ZMTP_UNSPECIFIED :: 0x10000000
ZMQ_PROTOCOL_ERROR_ZMTP_UNEXPECTED_COMMAND :: 0x10000001
ZMQ_PROTOCOL_ERROR_ZMTP_INVALID_SEQUENCE :: 0x10000002
ZMQ_PROTOCOL_ERROR_ZMTP_KEY_EXCHANGE :: 0x10000003
ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_UNSPECIFIED :: 0x10000011
ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_MESSAGE :: 0x10000012
ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_HELLO :: 0x10000013
ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_INITIATE :: 0x10000014
ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_ERROR :: 0x10000015
ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_READY :: 0x10000016
ZMQ_PROTOCOL_ERROR_ZMTP_MALFORMED_COMMAND_WELCOME :: 0x10000017
ZMQ_PROTOCOL_ERROR_ZMTP_INVALID_METADATA :: 0x10000018
// the following two may be due to erroneous configuration of a peer
ZMQ_PROTOCOL_ERROR_ZMTP_CRYPTOGRAPHIC :: 0x11000001
ZMQ_PROTOCOL_ERROR_ZMTP_MECHANISM_MISMATCH :: 0x11000002
ZMQ_PROTOCOL_ERROR_ZAP_UNSPECIFIED :: 0x20000000
ZMQ_PROTOCOL_ERROR_ZAP_MALFORMED_REPLY :: 0x20000001
ZMQ_PROTOCOL_ERROR_ZAP_BAD_REQUEST_ID :: 0x20000002
ZMQ_PROTOCOL_ERROR_ZAP_BAD_VERSION :: 0x20000003
ZMQ_PROTOCOL_ERROR_ZAP_INVALID_STATUS_CODE :: 0x20000004
ZMQ_PROTOCOL_ERROR_ZAP_INVALID_METADATA :: 0x20000005
ZMQ_PROTOCOL_ERROR_WS_UNSPECIFIED :: 0x30000000

Context :: rawptr

@(default_calling_convention="c", link_prefix="zmq_")
foreign zmq {
    /*
        ZMQ_EXPORT void *zmq_socket (void *, int type_);
ZMQ_EXPORT int zmq_close (void *s_);
ZMQ_EXPORT int
zmq_setsockopt (void *s_, int option_, const void *optval_, size_t optvallen_);
ZMQ_EXPORT int
zmq_getsockopt (void *s_, int option_, void *optval_, size_t *optvallen_);
ZMQ_EXPORT int zmq_bind (void *s_, const char *addr_);
ZMQ_EXPORT int zmq_connect (void *s_, const char *addr_);
ZMQ_EXPORT int zmq_unbind (void *s_, const char *addr_);
ZMQ_EXPORT int zmq_disconnect (void *s_, const char *addr_);
ZMQ_EXPORT int zmq_send (void *s_, const void *buf_, size_t len_, int flags_);
ZMQ_EXPORT int
zmq_send_const (void *s_, const void *buf_, size_t len_, int flags_);
ZMQ_EXPORT int zmq_recv (void *s_, void *buf_, size_t len_, int flags_);
ZMQ_EXPORT int zmq_socket_monitor (void *s_, const char *addr_, int events_);
    */
    socket :: proc(ctx: Context, type: i32) -> rawptr ---
    close :: proc(socket: rawptr) -> i32 ---
    setsockopt :: proc(socket: rawptr, option: i32, optval: rawptr, optlen: c.size_t) -> i32 ---
    getsockopt :: proc(socket: rawptr, option: i32, optval: rawptr, optlen: ^c.size_t) -> i32 ---
    bind :: proc(socket: rawptr, endpoint: cstring) -> i32 ---
    connect :: proc(socket: rawptr, addr: cstring) -> i32 ---
    unbind :: proc(socket: rawptr, endpoint: cstring) -> i32 ---
    disconnect :: proc(socket: rawptr, endpoint: cstring) -> i32 ---
    send :: proc(socket: rawptr, buffer: rawptr, len: c.size_t, flags: i32) -> i32 ---
    send_const :: proc(socket: rawptr, buffer: rawptr, len: c.size_t, flags: i32) -> i32 ---
    recv :: proc(socket: rawptr, buffer: rawptr, len: c.size_t, flags: i32) -> i32 ---
    socket_monitor :: proc(socket: rawptr, addr: cstring, events: i32) -> i32 ---
}

/******************************************************************************/
/*  Hide socket fd type; this was before zmq_poller_event_t typedef below     */
/******************************************************************************/

fd_t :: c.int

/******************************************************************************/
/*  Message proxying                                                          */
/******************************************************************************/

@(default_calling_convention="c", link_prefix="zmq_")
foreign zmq {
    proxy :: proc(frontend: rawptr, backend: rawptr, capture: rawptr) -> i32 ---
    proxy_steerable :: proc(frontend: rawptr, backend: rawptr, capture: rawptr, control: rawptr) -> i32 ---
}

/******************************************************************************/
/*  Probe library capabilities                                                */
/******************************************************************************/

ZMQ_HAS_CAPABILITIES :: 1
@(default_calling_convention="c", link_prefix="zmq_")
foreign zmq {
    has :: proc(capability: cstring) -> i32 ---
}

/*  Deprecated aliases */
ZMQ_STREAMER :: 1
ZMQ_FORWARDER :: 2
ZMQ_QUEUE :: 3

/******************************************************************************/
/*  Encryption functions                                                      */
/******************************************************************************/

@(default_calling_convention="c", link_prefix="zmq_")
foreign zmq {
/*  Encode data with Z85 encoding. Returns encoded data                       */
z85_encode :: proc(dest: cstring, data: rawptr, size: c.size_t) -> cstring ---

/*  Decode data with Z85 encoding. Returns decoded data                       */
z85_decode :: proc(dest: rawptr, string: cstring) -> rawptr ---

/*  Generate z85-encoded public and private keypair with libsodium. */
/*  Returns 0 on success.                                                     */
curve_keypair :: proc(z85_public_key: cstring, z85_secret_key: cstring) -> i32 ---

/*  Derive the z85-encoded public key from the z85-encoded secret key.        */
/*  Returns 0 on success.                                                     */
curve_public :: proc(z85_public_key: cstring, z85_secret_key: cstring) -> i32 ---

}

@(default_calling_convention="c", link_prefix="zmq_")
foreign zmq {
    version :: proc(major: ^i32, minor: ^i32, patch: ^i32) ---
   

}



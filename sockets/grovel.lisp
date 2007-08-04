;;;; -*- Mode: lisp; indent-tabs-mode: nil -*-
;;;
;;; grovel.lisp --- Grovelling for socket constants and types.
;;;
;;; Copyright (C) 2005-2006, Matthew Backes  <lucca@accela.net>
;;; Copyright (C) 2005-2006, Dan Knapp  <dankna@accela.net>
;;; Copyright (C) 2007, Stelian Ionescu  <stelian.ionescu-zeus@poste.it>
;;; Copyright (C) 2007, Luis Oliveira  <loliveira@common-lisp.net>
;;;
;;; Permission is hereby granted, free of charge, to any person
;;; obtaining a copy of this software and associated documentation
;;; files (the "Software"), to deal in the Software without
;;; restriction, including without limitation the rights to use, copy,
;;; modify, merge, publish, distribute, sublicense, and/or sell copies
;;; of the Software, and to permit persons to whom the Software is
;;; furnished to do so, subject to the following conditions:
;;;
;;; The above copyright notice and this permission notice shall be
;;; included in all copies or substantial portions of the Software.
;;;
;;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;;; NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
;;; HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
;;; WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
;;; DEALINGS IN THE SOFTWARE.

;;; This file contains a lot of unused types and constants that should
;;; be cleaned up or at least commented out.

#-windows
(include "sys/socket.h" "sys/un.h" "netinet/in.h" "netinet/in_systm.h"
         "netinet/ip.h" "net/if.h" "netinet/tcp.h" "netdb.h" "errno.h"
         "arpa/inet.h")

#+windows (include "Winsock2.h" "Ws2tcpip.h")

(in-package :net.sockets)

;;; TODO: check if I didn't miss any from CL-POSIX.  --luis
(constantenum socket-error-values
  ((:eprotonosupport "EPROTONOSUPPORT" "WSAEPROTONOSUPPORT"))
  ((:esocktnosupport "ESOCKTNOSUPPORT" "WSAESOCKTNOSUPPORT"))
  ((:enotsock "ENOTSOCK" "WSAENOTSOCK"))
  ((:edestaddrreq "EDESTADDRREQ" "WSAEDESTADDRREQ"))
  ((:emsgsize "EMSGSIZE" "WSAEMSGSIZE"))
  ((:eprototype "EPROTOTYPE" "WSAEPROTOTYPE"))
  ((:enoprotoopt "ENOPROTOOPT" "WSAENOPROTOOPT"))
  ((:eremote "EREMOTE" "WSAEREMOTE"))
  #-windows ((:enolink "ENOLINK"))
  ((:epfnosupport "EPFNOSUPPORT" "WSAEPFNOSUPPORT"))
  ((:eafnosupport "EAFNOSUPPORT" "WSAEAFNOSUPPORT"))
  ((:eaddrinuse "EADDRINUSE" "WSAEADDRINUSE"))
  ((:eaddrnotavail "EADDRNOTAVAIL" "WSAEADDRNOTAVAIL"))
  ((:enetdown "ENETDOWN" "WSAENETDOWN"))
  ((:enetunreach "ENETUNREACH" "WSAENETUNREACH"))
  ((:enetreset "ENETRESET" "WSAENETRESET"))
  ((:econnaborted "ECONNABORTED" "WSAECONNABORTED"))
  ((:econnreset "ECONNRESET" "WSAECONNRESET"))
  ((:eisconn "EISCONN" "WSAEISCONN"))
  ((:enotconn "ENOTCONN" "WSAENOTCONN"))
  ((:eshutdown "ESHUTDOWN" "WSAESHUTDOWN"))
  ((:etoomanyrefs "ETOOMANYREFS" "WSAETOOMANYREFS"))
  ((:etimedout "ETIMEDOUT" "WSAETIMEDOUT"))
  ((:econnrefused "ECONNREFUSED" "WSAECONNREFUSED"))
  ((:ehostdown "EHOSTDOWN" "WSAEHOSTDOWN"))
  ((:ehostunreach "EHOSTUNREACH" "WSAEHOSTUNREACH"))
  ((:enonet "ENONET") :optional t)
  ((:enobufs "ENOBUFS" "WSAENOBUFS"))
  ((:eopnotsupp "EOPNOTSUPP" "WSAEOPNOTSUPP"))
  ;; The following are here because of Winsock only and I'm not 100%
  ;; if they are correct.  TODO: check these. So, for portability, we
  ;; probably really want to define here every possibly error even if
  ;; they are repeated from CL-POSIX otherwise we'll be generating
  ;; different conditions (POSIX-ERROR vs. SOCKET-ERROR) on different
  ;; platforms.
  ((:eagain "EAGAIN" "WSAEWOULDBLOCK")) ; is this right?
  ((:ebadf "EBADF" "WSAEBADF"))
  ((:eintr "EINTR" "WSAEINTR"))
  ((:einval "EINVAL" "WSAEINVAL"))
  ((:enomem "ENOMEM" "WSAENOBUFS"))
  ((:eacces "EACCES" "WSAEACCES"))
  ((:efault "EFAULT" "WSAEFAULT"))
  ((:emfile "EMFILE" "WSAEMFILE"))
  ((:einprogress "EINPROGRESS" "WSAEINPROGRESS"))
  ((:ealready "EALREADY" "WSAEALREADY"))
  ((:eloop "ELOOP" "WSAELOOP"))
  ((:enametoolong "ENAMETOOLONG" "WSAENAMETOOLONG"))
  ((:enotempty "ENOTEMPTY" "WSAENOTEMPTY"))
  ((:eusers "EUSERS" "WSAEUSERS"))
  ((:edquot "EDQUOT" "WSAEDQUOT"))
  ((:estale "ESTALE" "WSAESTALE"))
  #+windows ((:eproclim "WSAEPROCLIM"))
  #+windows ((:ediscon "WSAEDISCON"))
  #+windows ((:enomre "WSAENOMORE"))
  #+windows ((:ecancelled "WSAECANCELLED"))
  #+windows ((:einvalidproctable "WSAEINVALIDPROCTABLE"))
  #+windows ((:einvalidprovider "WSAEINVALIDPROVIDER"))
  #+windows ((:eproviderfailedinit "WSAEPROVIDERFAILEDINIT"))
  #+windows ((:erefused "WSAEREFUSED")))

;;;; sys/socket.h

(ctype socklen "socklen_t")
(ctype sa-family #-windows "sa_family_t" #+windows "short")

;;; socket() - socket address family
(constant (af-unspec "AF_UNSPEC" "PF_UNSPEC"))
(constant (af-inet "AF_INET" "PF_INET") :documentation "IPv4 Protocol family")
(constant (af-inet6 "AF_INET6" "PF_INET6")
          :documentation "IPv6 Protocol family")
(constant (af-local "AF_UNIX" "AF_LOCAL" "PF_UNIX" "PF_LOCAL")
          :documentation "File domain sockets")
(constant (af-packet "AF_PACKET" "PF_PACKET") :documentation "Raw packet access"
          :optional t)
(constant (af-route "AF_ROUTE" "PF_ROUTE")
          :documentation "Routing sockets" :optional t)
#-windows (constant (af-key "AF_KEY" "PF_KEY"))
(constant (af-netlink "AF_NETLINK" "PF_NETLINK")
          :documentation "Linux Netlink sockets" :optional t)

;;; socket() - socket type
(constant (sock-stream "SOCK_STREAM") :documentation "TCP")
(constant (sock-dgram "SOCK_DGRAM") :documentation "UDP")
(constant (sock-seqpacket "SOCK_SEQPACKET")
  :documentation "Reliable Sequenced Datagram Protocol" :optional t)
(constant (sock-raw "SOCK_RAW") :documentation "Raw protocol access"
          :optional t)
(constant (sock-rdm "SOCK_RDM")
          :documentation "Reliable Unordered Datagram Protocol" :optional t)

;;; socket() - socket protocol
(constant (ipproto-ip "IPPROTO_IP"))
(constant (ipproto-ipv6 "IPPROTO_IPV6"))
(constant (ipproto-icmp "IPPROTO_ICMP"))
(constant (ipproto-icmpv6 "IPPROTO_ICMPV6"))
(constant (ipproto-raw "IPPROTO_RAW"))
(constant (ipproto-tcp "IPPROTO_TCP"))
(constant (ipproto-udp "IPPROTO_UDP"))
#-(or windows darwin) (constant (ipproto-sctp "IPPROTO_SCTP"))

(cstruct sockaddr "struct sockaddr"
  (family "sa_family" :type #-windows sa-family #+windows :ushort))

(cstruct sockaddr-storage "struct sockaddr_storage"
  (family "ss_family" :type sa-family))

(cstruct hostent "struct hostent"
  (name      "h_name"      :type :string)
  (aliases   "h_aliases"   :type :pointer)
  (type      "h_addrtype"  :type :int)
  (length    "h_length"    :type :int)
  (addresses "h_addr_list" :type :pointer))

(cstruct servent "struct servent"
  (name    "s_name"    :type :string)
  (aliases "s_aliases" :type :pointer)
  (port    "s_port"    :type :int)
  (proto   "s_proto"   :type :string))

(constant (somaxconn "SOMAXCONN")
  :documentation "Maximum listen() queue length")

(constant (sol-socket "SOL_SOCKET")
  :documentation "get/setsockopt socket level constant.")

#+linux
(progn
  (constant (sol-tcp "SOL_TCP")
            :documentation "get/setsockopt TCP level constant.")
  (constant (sol-ip "SOL_IP")
            :documentation "get/setsockopt IP level constant.")
  (constant (sol-raw "SOL_RAW")
            :documentation "get/setsockopt raw level constant."))

;;; getsockopt/setsockopt()
(constant (so-acceptconn "SO_ACCEPTCONN"))
(constant (so-acceptfilter "SO_ACCEPTFILTER") :optional t)    ; freebsd
(constant (so-bindtodevice "SO_BINDTODEVICE") :optional t)    ; linux
(constant (so-bintime "SO_BINTIME") :optional t)              ; freebsd
(constant (so-broadcast "SO_BROADCAST"))
(constant (so-bsdcompat "SO_BSDCOMPAT") :optional t)       ; linux
(constant (so-debug "SO_DEBUG"))
(constant (so-dontroute "SO_DONTROUTE"))
(constant (so-error "SO_ERROR"))
(constant (so-keepalive "SO_KEEPALIVE"))
(constant (so-label "SO_LABEL") :optional t)                  ; freebsd
(constant (so-linger "SO_LINGER"))
(constant (so-listenincqlen "SO_LISTENINCQLEN") :optional t)  ; freebsd
(constant (so-listenqlen "SO_LISTENQLEN") :optional t)        ; freebsd
(constant (so-listenqlimit "SO_LISTENQLIMIT") :optional t)    ; freebsd
(constant (so-nosigpipe "SO_NOSIGPIPE") :optional t)          ; freebsd
(constant (so-oobinline "SO_OOBINLINE"))
(constant (so-passcred "SO_PASSCRED") :optional t) ; linux
(constant (so-peercred "SO_PEERCRED") :optional t) ; linux
(constant (so-peerlabel "SO_PEERLABEL") :optional t)          ; freebsd
(constant (so-priority "SO_PRIORITY") :optional t) ; linux
(constant (so-rcvbuf "SO_RCVBUF"))
(constant (so-rcvlowat "SO_RCVLOWAT"))
(constant (so-rcvtimeo "SO_RCVTIMEO"))
(constant (so-reuseaddr "SO_REUSEADDR"))
(constant (so-reuseport "SO_REUSEPORT") :optional t)          ; freebsd
(constant (so-sndbuf "SO_SNDBUF"))
(constant (so-sndlowat "SO_SNDLOWAT"))
(constant (so-sndtimeo "SO_SNDTIMEO"))
#-windows (constant (so-timestamp "SO_TIMESTAMP"))
(constant (so-type "SO_TYPE"))
(constant (so-useloopback "SO_USELOOPBACK") :optional t)      ; freebsd
(constant (tcp-cork "TCP_CORK") :optional t)                  ; linux
(constant (tcp-defer-accept "TCP_DEFER_ACCEPT") :optional t)  ; linux
(constant (tcp-info "TCP_INFO") :optional t)                  ; linux
(constant (tcp-keepcnt "TCP_KEEPCNT") :optional t)            ; linux
(constant (tcp-keepidle "TCP_KEEPIDLE") :optional t)          ; linux
(constant (tcp-keepintvl "TCP_KEEPINTVL") :optional t)        ; linux
(constant (tcp-linger2 "TCP_LINGER2") :optional t)            ; linux
(constant (tcp-maxseg "TCP_MAXSEG") :optional t)              ; linux, freebsd
(constant (tcp-nodelay "TCP_NODELAY") :optional t)            ; linux, freebsd
(constant (tcp-noopt "TCP_NOOPT") :optional t)                ; freebsd
(constant (tcp-nopush "TCP_NOPUSH") :optional t)              ; freebsd
(constant (tcp-quickack "TCP_QUICKACK") :optional t)          ; linux
(constant (tcp-syncnt "TCP_SYNCNT") :optional t)              ; linux
(constant (tcp-window "TCP_WINDOW") :optional t)              ; linux

;;; shutdown()
(constant (shut-rd "SHUT_RD" "SD_RECEIVE"))
(constant (shut-wr "SHUT_WR" "SD_SEND"))
(constant (shut-rdwr "SHUT_RDWR" "SD_BOTH"))

;;; recvmsg/sendmsg()
(constant (msg-dontroute "MSG_DONTROUTE"))            ;         sendmsg
(constant (msg-oob "MSG_OOB"))                        ; recvmsg sendmsg
(constant (msg-peek "MSG_PEEK"))                      ; recvmsg
(constant (msg-errqueue "MSG_ERRQUEUE") :optional t)  ; recvmsg
(constant (msg-more "MSG_MORE") :optional t)          ;         sendmsg
(constant (msg-confirm "MSG_CONFIRM") :optional t)    ; sendmsg sendmsg
(constant (msg-proxy "MSG_PROXY") :optional t)        ;
(constant (msg-fin "MSG_FIN") :optional t)            ;
(constant (msg-syn "MSG_SYN") :optional t)            ;
(constant (msg-eof "MSG_EOF") :optional t)            ;
(constant (msg-nbio "MSG_NBIO") :optional t)          ;
(constant (msg-compat "MSG_COMPAT") :optional t)      ;
#-windows
(progn
  (constant (msg-trunc "MSG_TRUNC"))                  ; recvmsg
  (constant (msg-waitall "MSG_WAITALL"))              ; recvmsg
  (constant (msg-dontwait "MSG_DONTWAIT"))            ; recvmsg sendmsg
  #-darwin (constant (msg-nosignal "MSG_NOSIGNAL"))   ;         sendmsg
  (constant (msg-eor "MSG_EOR"))                      ; recvmsg sendmsg
  (constant (msg-ctrunc "MSG_CTRUNC")))               ; recvmsg

#-(and) ; unused
(cstruct msghdr "struct msghdr"
  (name       "msg_name"       :type :pointer)
  (namelen    "msg_namelen"    :type socklen)
  (iov        "msg_iov"        :type :pointer)
  (iovlen     "msg_iovlen"     :type size)
  (control    "msg_control"    :type :pointer)
  (controllen "msg_controllen" :type socklen)
  (flags      "msg_flags"      :type :int))

#-(and) ; unused
(cstruct cmsghdr "struct cmsghdr"
  (len   "cmsg_len"   :type socklen)
  (level "cmsg_level" :type :int)
  (type  "cmsg_type"  :type :int))

#-(and) ; unused
(constant (cmgroup-max "CMGROUP_MAX") :optional t)

#+(or (or) freebsd) ; unused
(cstruct cmsgcred "struct cmsgcred"
  (pid     "cmcred_pid"     :type pid)
  (uid     "cmcred_uid"     :type uid)
  (euid    "cmcred_euid"    :type uid)
  (gid     "cmcred_gid"     :type gid)
  (ngroups "cmcred_ngroups" :type :short)
  (groups  "cmcred_groups"  :type gid :count :auto))

#-(and) ; unused
(constant (scm-rights "SCM_RIGHTS"))
(constant (scm-credentials "SCM_CREDENTIALS") :optional t)

#+linux
(cstruct ucred "struct ucred"
  "Socket credential messages."
  (pid "pid" :type pid)
  (uid "uid" :type uid)
  (gid "gid" :type gid))

#+freebsd
(cstruct sockcred "struct sockcred"
  (uid     "sc_uid"     :type uid)
  (euid    "sc_euid"    :type uid)
  (gid     "sc_gid"     :type gid)
  (egid    "sc_egid"    :type gid)
  (ngroups "sc_ngroups" :type :int)
  (groups  "sc_groups"  :type gid :count :auto))

(cstruct linger "struct linger"
  "SO_LINGER manipulation record."
  (onoff  "l_onoff"  :type :int)
  (linger "l_linger" :type :int))

#+freebsd
(cstruct accept-filter-arg "struct accept_filter_arg"
  (name "af_name" :type :uint8 :count :auto)
  (arg  "af_arg"  :type :uint8 :count :auto))

;;;; from sys/un.h

#-windows
(cstruct sockaddr-un "struct sockaddr_un"
  "A UNIX-domain socket address."
  (family "sun_family" :type sa-family)
  (path   "sun_path"   :type :uint8 :count :auto))

#+freebsd
(progn
  (constant (local-peercred "LOCAL_PEERCRED"))
  (constant (local-creds "LOCAL_CREDS"))
  (constant (local-connwait "LOCAL_CONNWAIT")))

;;;; from netinet/in.h

(ctype in-port #-windows "in_port_t" #+windows "u_short")
(ctype in-addr #-windows "in_addr_t" #+windows "u_long")

(cstruct sockaddr-in "struct sockaddr_in"
  "An IPv4 socket address."
  (family "sin_family" :type sa-family)
  (port   "sin_port"   :type in-port)
  (addr   "sin_addr"   :type in-addr))

(cstruct in-addr-struct "struct in_addr"
  (addr "s_addr" :type :uint32))

(cunion in6-addr "struct in6_addr"
  "An IPv6 address."
  (addr8  "s6_addr"   :type :uint8  :count :auto)
  (addr16 "s6_addr16" :type :uint16 :count :auto)
  (addr32 "s6_addr32" :type :uint32 :count :auto))

(cstruct sockaddr-in6 "struct sockaddr_in6"
  "An IPv6 socket address."
  (family   "sin6_family"   :type sa-family)
  (port     "sin6_port"     :type in-port)
  (flowinfo "sin6_flowinfo" :type :uint32)
  (addr     "sin6_addr"     :type in6-addr)
  (scope-id "sin6_scope_id" :type :uint32))

#-(and) ; unused
(progn
  (constant (inaddr-any "INADDR_ANY"))
  (constant (inaddr-broadcast "INADDR_BROADCAST"))
  (constant (inaddr-none "INADDR_NONE"))
  (constant (in-loopbacknet "IN_LOOPBACKNET"))
  (constant (inaddr-loopback "INADDR_LOOPBACK"))
  (constant (inaddr-unspec-group "INADDR_UNSPEC_GROUP"))
  (constant (inaddr-allhosts-group "INADDR_ALLHOSTS_GROUP"))
  (constant (inaddr-allrtrs-group "INADDR_ALLRTRS_GROUP"))
  (constant (inaddr-max-local-group "INADDR_MAX_LOCAL_GROUP")))

(constant (inet-addrstrlen "INET_ADDRSTRLEN"))
(constant (inet6-addrstrlen "INET6_ADDRSTRLEN"))

(constant (ipv6-join-group "IPV6_JOIN_GROUP"))
(constant (ipv6-leave-group "IPV6_LEAVE_GROUP"))
(constant (ipv6-multicast-hops "IPV6_MULTICAST_HOPS"))
(constant (ipv6-multicast-if "IPV6_MULTICAST_IF"))
(constant (ipv6-multicast-loop "IPV6_MULTICAST_LOOP"))
(constant (ipv6-unicast-hops "IPV6_UNICAST_HOPS"))
#-windows (constant (ipv6-v6only "IPV6_V6ONLY"))

;;;; from netinet/tcp.h

(constant (tcp-nodelay "TCP_NODELAY"))
#-windows (constant (tcp-maxseg "TCP_MAXSEG"))
#+linux
(constant (tcp-cork "TCP_CORK"))
(constant (tcp-keepidle "TCP_KEEPIDLE") :optional t)
(constant (tcp-keepintvl "TCP_KEEPINTVL") :optional t)
(constant (tcp-keepcnt "TCP_KEEPCNT") :optional t)
(constant (tcp-syncnt "TCP_SYNCNT") :optional t)
(constant (tcp-linger2 "TCP_LINGER2") :optional t)
(constant (tcp-defer-accept "TCP_DEFER_ACCEPT") :optional t)
(constant (tcp-window-clamp "TCP_WINDOW_CLAMP") :optional t)
#-(or windows darwin) (constant (tcp-info "TCP_INFO"))
(constant (tcp-quickack "TCP_QUICKACK") :optional t)

#+linux
(cenum connstates
  ((:tcp-established "TCP_ESTABLISHED"))
  ((:tcp-syn-sent "TCP_SYN_SENT"))
  ((:tcp-syn-recv "TCP_SYN_RECV"))
  ((:tcp-fin-wait1 "TCP_FIN_WAIT1"))
  ((:tcp-fin-wait2 "TCP_FIN_WAIT2"))
  ((:tcp-time-wait "TCP_TIME_WAIT"))
  ((:tcp-close "TCP_CLOSE"))
  ((:tcp-close-wait "TCP_CLOSE_WAIT"))
  ((:tcp-last-ack "TCP_LAST_ACK"))
  ((:tcp-listen "TCP_LISTEN"))
  ((:tcp-closing "TCP_CLOSING")))

;;;; from netdb.h

(constant (ipport-reserved "IPPORT_RESERVED"))

(cstruct addrinfo "struct addrinfo"
  (flags     "ai_flags"     :type :int)
  (family    "ai_family"    :type :int)
  (socktype  "ai_socktype"  :type :int)
  (protocol  "ai_protocol"  :type :int)
  (addrlen   "ai_addrlen"   :type socklen)
  (addr      "ai_addr"      :type :pointer)
  (canonname "ai_canonname" :type :pointer)
  (next      "ai_next"      :type :pointer))

;;; addrinfo flags
(constant (ai-passive "AI_PASSIVE"))
(constant (ai-canonname "AI_CANONNAME"))
(constant (ai-numerichost "AI_NUMERICHOST"))
#-(or windows darwin) (constant (ai-numericserv "AI_NUMERICSERV"))
#-windows (constant (ai-v4mapped "AI_V4MAPPED"))
(constant (ai-v4mapped-cfg "AI_V4MAPPED_CFG") :optional t) ; freebsd
#-windows (constant (ai-all "AI_ALL"))
#-windows (constant (ai-addrconfig "AI_ADDRCONFIG"))

(constant (ni-maxhost "NI_MAXHOST"))
(constant (ni-maxserv "NI_MAXSERV"))

;;; nameinfo flags
(constant (ni-nofqdn "NI_NOFQDN"))
(constant (ni-numerichost "NI_NUMERICHOST"))
(constant (ni-namereqd "NI_NAMEREQD"))
(constant (ni-numericserv "NI_NUMERICSERV"))
(constant (ni-numericscope "NI_NUMERICSCOPE") :optional t)
(constant (ni-dgram "NI_DGRAM"))

;;; error codes
#-windows (constant (netdb-success "NETDB_SUCCESS"))
#-windows (constant (netdb-internal "NETDB_INTERNAL"))

(constantenum addrinfo-errors
  #-windows ((:netdb-success "NETDB_SUCCESS"))
  ((:eai-addrfamily "EAI_ADDRFAMILY") :optional t) ; linux
  ((:eai-again "EAI_AGAIN"))
  ((:eai-badflags "EAI_BADFLAGS"))
  ((:eai-fail "EAI_FAIL"))
  ((:eai-family "EAI_FAMILY"))
  ((:eai-memory "EAI_MEMORY"))
  ((:eai-noname "EAI_NONAME"))
  ((:eai-nodata "EAI_NODATA") :optional t)         ; linux
  ((:eai-service "EAI_SERVICE"))
  ((:eai-socktype "EAI_SOCKTYPE"))
  ((:eai-system "EAI_SYSTEM" #+windows "EAI_FAIL"))
  ((:eai-badhints "EAI_BADHINTS") :optional t)     ; freebsd
  ((:eai-protocol "EAI_PROTOCOL") :optional t)     ; freebsd
  ((:eai-max "EAI_MAX") :optional t)               ; freebsd
  ((:eai-overflow "EAI_OVERFLOW") :optional t))    ; linux

(cstruct protoent "struct protoent"
  (name    "p_name"    :type :string)
  (aliases "p_aliases" :type :pointer)
  (proto   "p_proto"   :type :int))

;;;; from net/if.h

;;; On windows platforms, this is only supported on Vista and later.
#-windows
(progn
  (cstruct if-nameindex "struct if_nameindex"
           (index "if_index" :type :unsigned-int)
           (name  "if_name"  :type :string))

  (constant (ifnamesize "IF_NAMESIZE"))
  (constant (ifnamsiz "IFNAMSIZ")))

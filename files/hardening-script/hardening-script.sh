#!/bin/bash

# Set up UFW rules
ufw limit 22/tcp  
ufw allow 80/tcp  
ufw allow 443/tcp  
ufw default deny incoming  
ufw default allow outgoing
ufw enable

# Copy fail2ban configuration file to the right directory
cp jail.local /etc/fail2ban/

# Show listening ports
echo "Listening ports:"
netstat -tunlp

#!/bin/sh

# Define paths to required binaries
IPTABLES="/sbin/iptables"
IP6TABLES="/sbin/ip6tables"
MODPROBE="/sbin/modprobe"
RMMOD="/sbin/rmmod"
ARP="/usr/sbin/arp"
SSHPORT="22"

# Logging options
LOG="LOG --log-level debug --log-tcp-sequence --log-tcp-options"
LOG="$LOG --log-ip-options"

# Defaults for rate limiting
RLIMIT="-m limit --limit 3/s --limit-burst 8"

# Unprivileged ports range
PHIGH="1024:65535"
PSSH="1000:1023"

# Load required kernel modules
"$MODPROBE" ip_conntrack_ftp
"$MODPROBE" ip_conntrack_irc

# ARP spoofing protection
# Uncomment and hardcode static ARP cache entries if necessary
# $ARP -s IP-ADDRESS MAC-ADDRESS

# Disable IP forwarding temporarily
echo 1 > /proc/sys/net/ipv4/ip_forward
echo 0 > /proc/sys/net/ipv4/ip_forward

# Enable IP spoofing protection
for i in /proc/sys/net/ipv4/conf/*/rp_filter; do echo 1 > "$i"; done

# Protect against SYN flood attacks
echo 1 > /proc/sys/net/ipv4/tcp_syncookies

# Ignore all incoming ICMP echo requests
echo 0 > /proc/sys/net/ipv4/icmp_echo_ignore_all

# Ignore ICMP echo requests to broadcast
echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts

# Log packets with impossible addresses
for i in /proc/sys/net/ipv4/conf/*/log_martians; do echo 1 > "$i"; done

# Ignore bogus ICMP responses
echo 1 > /proc/sys/net/ipv4/icmp_ignore_bogus_error_responses

# Disable ICMP redirects
for i in /proc/sys/net/ipv4/conf/*/accept_redirects; do echo 0 > "$i"; done
for i in /proc/sys/net/ipv4/conf/*/send_redirects; do echo 0 > "$i"; done

# Disable source routing
for i in /proc/sys/net/ipv4/conf/*/accept_source_route; do echo 0 > "$i"; done

# Disable multicast routing
for i in /proc/sys/net/ipv4/conf/*/mc_forwarding; do echo 0 > "$i"; done

# Disable proxy ARP
for i in /proc/sys/net/ipv4/conf/*/proxy_arp; do echo 0 > "$i"; done

# Enable secure ICMP redirects for gateways
for i in /proc/sys/net/ipv4/conf/*/secure_redirects; do echo 1 > "$i"; done

# Disable bootp_relay
for i in /proc/sys/net/ipv4/conf/*/bootp_relay; do echo 0 > "$i"; done

# Default policies: Drop everything by default
"$IPTABLES" -P INPUT DROP
"$IPTABLES" -P FORWARD DROP
"$IPTABLES" -P OUTPUT DROP

# Accept all traffic in nat and mangle tables
"$IPTABLES" -t nat -P PREROUTING ACCEPT
"$IPTABLES" -t nat -P OUTPUT ACCEPT
"$IPTABLES" -t nat -P POSTROUTING ACCEPT

"$IPTABLES" -t mangle -P PREROUTING ACCEPT
"$IPTABLES" -t mangle -P INPUT ACCEPT
"$IPTABLES" -t mangle -P FORWARD ACCEPT
"$IPTABLES" -t mangle -P OUTPUT ACCEPT
"$IPTABLES" -t mangle -P POSTROUTING ACCEPT

# Clean up existing iptables rules
"$IPTABLES" -F
"$IPTABLES" -t nat -F
"$IPTABLES" -t mangle -F

"$IPTABLES" -X
"$IPTABLES" -t nat -X
"$IPTABLES" -t mangle -X

"$IPTABLES" -Z
"$IPTABLES" -t nat -Z
"$IPTABLES" -t mangle -Z

# IPv6: Block all traffic if ip6tables is available
if test -x "$IP6TABLES"; then
    "$IP6TABLES" -P INPUT DROP 2>/dev/null
    "$IP6TABLES" -P FORWARD DROP 2>/dev/null
    "$IP6TABLES" -P OUTPUT DROP 2>/dev/null

    "$IP6TABLES" -t mangle -P PREROUTING ACCEPT 2>/dev/null
    "$IP6TABLES" -t mangle -P INPUT ACCEPT 2>/dev/null
    "$IP6TABLES" -t mangle -P FORWARD ACCEPT 2>/dev/null
    "$IP6TABLES" -t mangle -P OUTPUT ACCEPT 2>/dev/null
    "$IP6TABLES" -t mangle -P POSTROUTING ACCEPT 2>/dev/null

    "$IP6TABLES" -F 2>/dev/null
    "$IP6TABLES" -t mangle -F 2>/dev/null

    "$IP6TABLES" -X 2>/dev/null
    "$IP6TABLES" -t mangle -X 2>/dev/null

    "$IP6TABLES" -Z 2>/dev/null
    "$IP6TABLES" -t mangle -Z 2>/dev/null
fi

# Custom chains for logging and handling traffic
"$IPTABLES" -N ACCEPTLOG
"$IPTABLES" -A ACCEPTLOG -j "$LOG" "$RLIMIT" --log-prefix "ACCEPT "
"$IPTABLES" -A ACCEPTLOG -j ACCEPT

"$IPTABLES" -N DROPLOG
"$IPTABLES" -A DROPLOG -j "$LOG" "$RLIMIT" --log-prefix "DROP "
"$IPTABLES" -A DROPLOG -j DROP

"$IPTABLES" -N REJECTLOG
"$IPTABLES" -A REJECTLOG -j "$LOG" "$RLIMIT" --log-prefix "REJECT "
"$IPTABLES" -A REJECTLOG -p tcp -j REJECT --reject-with tcp-reset
"$IPTABLES" -A REJECTLOG -j REJECT

"$IPTABLES" -N RELATED_ICMP
"$IPTABLES" -A RELATED_ICMP -p icmp --icmp-type destination-unreachable -j ACCEPT
"$IPTABLES" -A RELATED_ICMP -p icmp --icmp-type time-exceeded -j ACCEPT
"$IPTABLES" -A RELATED_ICMP -p icmp --icmp-type parameter-problem -j ACCEPT
"$IPTABLES" -A RELATED_ICMP -j DROPLOG

# Additional ICMP protections
"$IPTABLES" -A INPUT -p icmp -m limit --limit 1/s --limit-burst 2 -j ACCEPT
"$IPTABLES" -A INPUT -p icmp -j DROPLOG
"$IPTABLES" -A OUTPUT -p icmp -j ACCEPT

"$IPTABLES" -A INPUT -p icmp --fragment -j DROPLOG
"$IPTABLES" -A OUTPUT -p icmp --fragment -j DROPLOG
"$IPTABLES" -A FORWARD -p icmp --fragment -j DROPLOG

"$IPTABLES" -A INPUT -p icmp -m state --state ESTABLISHED -j ACCEPT "$RLIMIT"
"$IPTABLES" -A OUTPUT -p icmp -m state --state ESTABLISHED -j ACCEPT "$RLIMIT"

"$IPTABLES" -A INPUT -p icmp -m state --state RELATED -j RELATED_ICMP "$RLIMIT"
"$IPTABLES" -A OUTPUT -p icmp -m state --state RELATED -j RELATED_ICMP "$RLIMIT"

# Handle loopback traffic
"$IPTABLES" -A INPUT -i lo -j ACCEPT
"$IPTABLES" -A OUTPUT -o lo -j ACCEPT

# Allow established and related traffic
"$IPTABLES" -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
"$IPTABLES" -A OUTPUT -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# Drop invalid packets
"$IPTABLES" -A INPUT -m state --state INVALID -j DROP
"$IPTABLES" -A OUTPUT -m state --state INVALID -j DROP
"$IPTABLES" -A FORWARD -m state --state INVALID -j DROP

# Block port scanners
"$IPTABLES" -A INPUT -m state --state NEW -p tcp --tcp-flags ALL ALL -j DROP
"$IPTABLES" -A INPUT -m state --state NEW -p tcp --tcp-flags ALL NONE -j DROP

"$IPTABLES" -A INPUT -p tcp ! --syn -m state --state NEW -j DROP

# Block packets claiming to be from reserved IP addresses
"$IPTABLES" -A INPUT -s 224.0.0.0/3 -j DROPLOG
"$IPTABLES" -A INPUT -s 169.254.0.0/16 -j DROPLOG
"$IPTABLES" -A INPUT -s 172.16.0.0/12 -j DROPLOG
"$IPTABLES" -A INPUT -s 192.0.2.0/24 -j DROPLOG
"$IPTABLES" -A INPUT -s 192.168.0.0/16 -j DROPLOG
"$IPTABLES" -A INPUT -s 10.0.0.0/8 -j DROPLOG

# Block broadcast requests
"$IPTABLES" -A INPUT -m pkttype --pkt-type broadcast -j DROPLOG

# Block multicasts and limited broadcast addresses
"$IPTABLES" -A INPUT -s 0.0.0.0/8 -j DROPLOG

# Block localhost addresses coming from other interfaces
"$IPTABLES" -A INPUT -s 127.0.0.0/8 ! -i lo -j DROPLOG

# Drop all other incoming traffic to privileged ports (0-1023)
"$IPTABLES" -A INPUT -p tcp --dport 0:$PSSH -j DROPLOG
"$IPTABLES" -A INPUT -p udp --dport 0:$PSSH -j DROPLOG

# Set default policy to drop all other traffic
"$IPTABLES" -A INPUT -j DROPLOG

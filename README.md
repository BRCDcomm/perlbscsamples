# perlbscsamples
Sample applications demonstrating use of [perlbsc](https://github.com/BRCDcomm/perlbsc) to monitor/configure network via Brocade SDN Controller (Brocade SDN Controller).

## Documentation:

## Pre-requisites:
* [perlbsc](https://github.com/BRCDcomm/perlbsc)

## Installation
```bash
   git clone https://github.com/BRCDcomm/perlbscsamples.git
```

## Brocade SDN Controller Version Support:
* 1.3.0 folder has been tested with Brocade SDN Controller 1.3.0 and perlbsc 1.0.4


## Sample Apps

* 1.3.0/sample_openflow/demos/
    * _demo_1.pl_: Get list of OpenFlow nodes and provide generic info for each.
    * _demo_2.pl_: Get detailed info about node with specific name (default node name is openflow:1).
    * _demo_3.pl_: Get detailed info about ports on a node with specific name (default node name is openflow:1).
    * _demo_4.pl_: Add/remove flow to openflow:1 node that Match: Ethernet Type 0x800, IPv4 destination 10.11.12.13/24 Action: Drop
    * _demo_5.pl_: Add/remove flow to openflow:1 node that Match: Ethernet Type 0x800, IPv4 source 10.11.12.13/24 Action: Drop
    * _demo_6.pl_: Add/remove flow to openflow:1 node that Match: Ethernet Type 0x2d, Ethernet source 00:00:00:00:23:ae, Ethernet destination ff:ff:ff:ff:ff:ff Action: drop
    * _demo_7.pl_:  Add/remove flow to openflow:1 node that Match: Ethernet Type 0x800, Ethernet source 00:1a:1b:00:22:aa, Ethernet destination 00:2b:00:60:ff:f1, IPv4 source 44.44.44.1/24, IPv4 destination 55.55.55.1/16, Input Port 13 Action: Output (controller)
    * _demo_8.pl_: Add/remove flow to openflow:1 node that Match: Ethernet Type 0x800, Ethernet source 00:1c:01:00:23:aa, Ethernet destination 00:02:02:60:ff:fe, IPv4 source 10.0.245.1/24, IPv4 destination 192.168.1.123/16, IP Protocol Number 56, IP DSCP 15, Input Port 1 Action: Output (controller)
    * _demo_9.pl_: Add/remove flow to openflow:1 node that Match: Ethernet Type 0x800, Ethernet source 00:00:00:11:23:ae, Ethernet destination ff:ff:29:01:19:61, IPv4 source 17.1.2.3/8, IPv4 destination 172.168.5.6/16, IP Protocol Number 6, IP DSCP 2, TCP Source Port 25364, TCP Destination Port 8080, Input Port 13 Action: Output (normal)
    * _demo_10.pl_: Add/remove flow to openflow:1 node that Match: Ethernet Type 0x800, Ethernet source 00:00:00:11:23:ae, Ethernet destination 20:14:29:01:19:61, IPv4 source 192.1.2.3/10, IPv4 destination 172.168.5.6/18, IP Protocol Number 17, IP DSCP 8, IP ECN 3, UDP Source Port 25364, UDP Destination Port 8080, Input Port 13 Action: Output (normal)
    * _demo_11.pl_: Add/remove flow to openflow:1 node that Match: Ethernet Type 0x800, Ethernet source 00:00:00:11:23:ae, Ethernet destination 00:ff:20:01:1a:3d, IPv4 source 17.1.2.3/8, IPv4 destination 172.168.5.6/18, IP Protocol Number 1, IP DSCP 27, IP ECN 3, ICMPv4 Type 6, ICMPv4 Code 3, Input Port 10 Action: Output (normal)
    * _demo_12.pl_: Add/remove flow to openflow:1 node that Match: Ethernet Type 0x806, Ethernet source 11:ab:fe:01:03:31,Ethernet destination ff:ff:ff:ff:ff:ff, ARP Operation 1,ARP source IPv4 192.168.4.1, ARP target IPv4 10.21.22.23ARP source hardware address 12:34:56:78:98:ab,ARP target hardware address fe:dc:ba:98:76:54 Action: Output (controller)
    * _demo_13.pl_: Add/remove flow to openflow:1 node that Match: Ethernet Type 0x800, Ethernet source 00:00:00:11:23:ad,Ethernet destination 00:ff:29:01:19:61, VLAN ID 100, VLAN PCP 3 Action: Output (controller)
    * _demo_14.pl_: Add/remove flow to openflow:1 node that Match: Ethernet Type 0x800, Ethernet source 00:00:00:AA:BB:CC, Ethernet destination FF:FF:AA:BC:ED:FE, Input port 5 Action: Push VLAN / Set Field (VLAN ID 100) / Output (physical port)
    * _demo_15.pl_: Add/remove flow to openflow:1 node that pushes ethernet type VLAN traffic to a particular VLAN ID and port 
    * _demo_16.pl_: Add/remove flow to openflow:1 node that Match: Ethernet Type 0x86dd, IPv6 Source fe08::2acf:e9ff:fe21:6431/128, IPv6 Destination aabb:1234:2acf:e9ff::fe21:6431/64 Action: Output (controller)
    * _demo_17.pl_: Add/remove flow to openflow:1 node that Match: Ethernet Type 0x86dd, IPv6 Source fe80::2acf:e9ff:fe21:6431/128, IPv6 Destination aabb:1234:2acf:e9ff::fe21:6431/64, IP DSCP 8, UDP Source Port 25364, UDP Destination Port 7777 Action: Output (controller)
    * _demo_18.pl_: Add/remove flow to openflow:1 node that Match: Ethernet Type 0x86dd, IPv6 Source 2001::2acf:e9ff:fe21:6431/80, IPv6 Destination 2004:1234:2acf:e9ff::fe21:6431/64, IP DSCP 8, TCP Source Port 12345, TCP Destination Port 54321 Action: Output (controller)
    * _demo_19.pl_: Add/remove flow to openflow:1 node that Match: Ethernet Type 0x86dd, IPv6 Source 4321::3210:3210:3210:3210/80, IPv6 Destination 1234:1234:1234:1234::5678:5678/64, IPv6 Flow Label 33, IP DSCP 60, TCP Source Port 11111, TCP Destination Port 22222 Action: Output (controller)
    * _demo_20.pl_: Add/remove flow to openflow:1 node that Match: Ethernet Type 0x86dd, IPv6 Source 1234:5678:9ABC:DEF0:FDCD:A987:6543:210F/76, IPv6 Destination 2000:2abc:edff:fe00::3456/94, IPv6 Flow Label 15, IP DSCP 60, IP ECN 3, ICMPv6 Type 6, ICPMv6 Code 3, Metadata: 0x0123456789ABCDEF Action: Output (controller)
    * _demo_21.pl_: Add/remove flow to openflow:1 node that Match: Ethernet Type 0x86dd, IPv6 Source 1234:5678:9ABC:DEF0:FDCD:A987:6543:210F/76, IPv6 Destination 2000:2abc:edff:fe00::3456/94, IPv6 Flow Label 7, IP DSCP 60, IP ECN 3, TCP Source 1831, TCP Destination 100610, Metadata: 123456789 Action: Output (controller)
    * _demo_23.pl_: Add/remove flow to openflow:1 node that Match: Ethernet Type 0x8847, MPLS Label 0x1b In port 13 Action: Set Field (MPLS Label 44, Output (Physical Port Number 14)
    * _demo_24.pl_: Add/remove flow to openflow:1 node that Match: Ethernet Type 0x8847, MPLS Label 0x2c In port 14 Action: Pop MPLS (Ethernet Type 34887, Output (Physical Port Number 13)
    * _demo_25.pl_: Add/remove flow to openflow:1 node that Match: Ethernet Type 0x8847, VLAN ID: 998, In port 110 Action: Push VLAN: <ethertype stag>, Set Field VLAN ID: 998, Output 111
    * _demo_26.pl_: Add/remove multiple flows to openflow:1 node.

* 1.3.0/sample_netconf/demos
    * _controller_demo_1.pl_: List of YANG models supported by the Controller.
    * _controller_demo_2.pl_: Retrieve specific YANG model definition from the Controller.
    * _controller_demo_3.pl_: List of service provider applications on the controller.
    * _controller_demo_4.pl_: Retrieve specific service provider info.
    * _controller_demo_5.pl_: List of all NETCONF operations supported by the Controller.
    * _controller_demo_6.pl_: Show operational state of all configuration modules on the Controller.
    * _controller_demo_7.pl_: Show operational state of a particular configuration module.
    * _controller_demo_8.pl_: Show active sessions on the Controller.
    * _controller_demo_9.pl_: Show notification event streams registered on the Controller.
    * _controller_demo_10.pl_: Add/remove a NETCONF node to the controller.
    * _vr_demo_1.pl_: Get supported models of vRouter connected to Controller.
    * _vr_demo_2.pl_: Get definition of specific model of vRouter connected.
    * _vr_demo_3.pl_: Get vRouter configuration.
    * _vr_demo_4.pl_: Get firewall configuration for vRouter.
    * _vr_demo_5.pl_: Get information on dataplane interfaces configured on vRouter.
    * _vr_demo_6.pl_: Get information on loopback interfaces configured on vRouter".
    * _vr_demo_7.pl_: Create complex firewalls for vRouter
    * _vr_demo8_: adds and removes a VPN configuration for Remote Access VPN Configuration Example - L2TP/IPsec with Pre-Shared Key
    * _vr_demo9_: adds and removes a VPN configuration for Remote Access VPN Configuration Example - L2TP/IPsec with X.509 Certificates
    * _vr_demo10_: adds and removes a VPN configuration for site-to-site VPN with pre-shared key (PSK) authentication
    * _vr_demo11_: adds and removes a VPN configuration for site-to-site VPN with RSA Digital Signature authentication
    * _vr_demo12_: adds and removes a VPN configuration for Site-to-Site VPN Configuration - X.509 Certificate Authentication
    * _vr_demo13_: adds and removes a vtun0 OpenVPN tunnel for Site-to-Site Mode with Preshared Secret
    * _vr_demo14_: adds and removes a vtun0 OpenVPN tunnel for Site-to-Site Mode with TLS
* 1.3.0/sample_netconf/cmds
    * _mount.pl_: Mount the vRouter onto Controller.
    * _show_cfg.pl_: Show config of vRouter.
    * _show_ctrl_yangmodel.pl_: Return a specified YANG model.
    * _show_ctrl_yangmodels.pl_: Display a list of available YANG models in Controller..
    * _show_dpifcfg.pl_: List configuration of each dataplane interface in vRouter.
    * _show_dpiflist.pl_: List dataplane interfaces of vRouter.
    * _show_firewallcfg.pl_: Show firewall configuration of vRouter.
    * _show_iflist.pl_: List interfaces of vRouter.
    * _show_lbifcfg.pl_: List configuration of each loopback interface in vRouter.
    * _show_lbiflist.pl_: List loopback interfaces of vRouter.
    * _show_mount.pl_: List NETCONF nodes mounted on controller and their connection status.
    * _show_nodeinfo.pl_: List info about node specified in config.yml file.
    * _show_nodelist.pl_: List all nodes known by the Controller.
    * _show_yangmodel.pl_: Return a specified YANG model from vRouter device.
    * _show_yangmodels.pl_: Display a list of available YANG models in vRouter device.
    * _unmount.pl_: Unmount the vRouter specified in config.yml file.


#!/usr/bin/perl

# Copyright (c) 2015,  BROCADE COMMUNICATIONS SYSTEMS, INC
#
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice,
# this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice,
# this list of conditions and the following disclaimer in the documentation
# and/or other materials provided with the distribution.
#
# 3. Neither the name of the copyright holder nor the names of its
# contributors may be used to endorse or promote products derived from this
# software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
# THE POSSIBILITY OF SUCH DAMAGE.

use strict;
use warnings;

use Getopt::Long;
use Brocade::BSC;
use Brocade::BSC::Const qw(/ETH_TYPE/ /IP_/);
use Brocade::BSC::Node::OF::Switch;
use Brocade::BSC::Node::OF::FlowEntry;
use Brocade::BSC::Node::OF::Match;
use Brocade::BSC::Node::OF::Action::Output;

my $configfile = "";
my $status = undef;
my $flowinfo = undef;

my $ethtype = $ETH_TYPE_IPv4;
my $eth_src = "00:00:00:11:23:ae";
my $eth_dst = "00:ff:20:01:1a:3d";
my $ipv4_src = "17.1.2.3/8";
my $ipv4_dst = "172.168.5.6/18";
my $ip_proto = $IP_PROTO_ICMP;
my $ip_dscp  = $IP_DSCP_CS2;    # Class Selector 2 'Immediate'
my $ip_ecn   = $IP_ECN_CE;      # Congestion Encountered
my $icmpv4_type = 6;            # Alternate Host Address (deprecated)
my $icmpv4_code = 3;            # huh?  type 6 ever had sub-types??
my $input_port = 10;

my $table_id = 0;
my $flow_id  = 18;
my $flow_priority = 1009;

GetOptions("config=s" => \$configfile) or die ("Command line args");

print ("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n");
print ("<<< Demo Start\n");
print ("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n\n");

my $bvc = new Brocade::BSC(cfgfile => $configfile);
my $ofswitch = new Brocade::BSC::Node::OF::Switch(cfgfile => $configfile,
                                           ctrl => $bvc);
print "<<< 'Controller': $bvc->{ipAddr}, 'OpenFlow' switch: $ofswitch->{name}\n\n";

print  "<<< Set OpenFlow flow on the Controller\n";
printf "        Match:  Ethernet Type                (0x%04x)\n", $ethtype;
print  "                Ethernet Source Address      ($eth_src)\n";
print  "                Ethernet Destination Address ($eth_dst)\n";
print  "                IPv4 Source Address          ($ipv4_src)\n";
print  "                IPv4 Destination Address     ($ipv4_dst)\n";
print  "                IP Protocol Number           ($ip_proto)\n";
print  "                IP DSCP                      ($ip_dscp)\n";
print  "                IP ECN                       ($ip_ecn)\n";
print  "                ICMPv4 Type                  ($icmpv4_type)\n";
print  "                ICMPv4 Code                  ($icmpv4_code)\n";
print  "                Input Port                   ($input_port)\n";
print  "        Action: Output (NORMAL)\n\n";

my $flowentry = new Brocade::BSC::Node::OF::FlowEntry;
$flowentry->table_id($table_id);
$flowentry->id($flow_id);
$flowentry->priority($flow_priority);

# # --- Instruction: 'Apply-action'
# #     Action:      'Output' NORMAL
my $instruction = $flowentry->add_instruction(0);
my $action = new Brocade::BSC::Node::OF::Action::Output(order => 0,
                                               port => 'NORMAL');
$instruction->apply_actions($action);

# # --- Match Fields

my $match = new Brocade::BSC::Node::OF::Match();
$match->eth_type($ethtype);
$match->eth_src($eth_src);
$match->eth_dst($eth_dst);
$match->ipv4_src($ipv4_src);
$match->ipv4_dst($ipv4_dst);
$match->ip_proto($ip_proto);
$match->ip_dscp($ip_dscp);
$match->ip_ecn($ip_ecn);
$match->icmpv4_type($icmpv4_type);
$match->icmpv4_code($icmpv4_code);
$match->in_port($input_port);
$flowentry->add_match($match);

print "<<< Flow to send:\n";
print $flowentry->get_payload() . "\n\n";

$status = $ofswitch->add_modify_flow($flowentry);
$status->ok or die "!!! Demo terminated, reason: ${\$status->msg}\n";
print "<<< Flow successfully added to the Controller\n\n";

($status, $flowinfo) = $ofswitch->get_configured_flow($table_id, $flow_id);
$status->ok or die "!!! Demo terminated, reason: ${\$status->msg}\n";
print "<<< Flow successfully read from the Controller\n";
print "Flow info:\n";
print JSON->new->pretty->encode(JSON::decode_json($flowinfo)) . "\n";

print "<<< Delete flow with id of '$flow_id' from the Controller's cache\n";
print "        and from table '$table_id' on the '$ofswitch->{name}' node\n\n";
$status = $ofswitch->delete_flow($flowentry->table_id,
                                 $flowentry->id);
$status->ok or die "!!! Demo terminated, reason: ${\$status->msg}\n";
print "<<< Flow successfully removed from the Controller\n";


print ("\n");
print (">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n");
print (">>> Demo End\n");
print (">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n");

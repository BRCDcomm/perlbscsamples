#!/usr/bin/perl

use strict;
use warnings;

use Getopt::Long;
use Brocade::BSC;
use Brocade::BSC::Const qw(/ETH_TYPE/);
use Brocade::BSC::Openflow::OFSwitch;
use Brocade::BSC::Openflow::FlowEntry;
use Brocade::BSC::Openflow::Match;
use Brocade::BSC::Openflow::Action::Drop;

my $configfile = "";
my $status = undef;
my $flowinfo = undef;

my $ethtype = $ETH_TYPE_IPv4;
my $ipv4_src = "10.11.12.13/24";
my $table_id = 0;
my $flow_id  = 12;
my $flow_priority = 1000;

GetOptions("config=s" => \$configfile) or die ("Command line args");

print ("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n");
print ("<<< Demo Start\n");
print ("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n\n");

my $bvc = new Brocade::BSC(cfgfile => $configfile);
my $ofswitch = new Brocade::BSC::Openflow::OFSwitch(cfgfile => $configfile,
                                           ctrl => $bvc);
print "<<< 'Controller': $bvc->{ipAddr}, "
    . "'OpenFlow' switch: $ofswitch->{name}\n\n";

print  "<<< Set OpenFlow flow on the Controller\n";
printf "        Match: Ethernet Type (0x%04x)\n", $ethtype;
print  "        IPv4 Source Address ($ipv4_src)\n";
print  "        Action: Drop\n\n";

my $flowentry = new Brocade::BSC::Openflow::FlowEntry;
$flowentry->table_id($table_id);
$flowentry->id($flow_id);
$flowentry->priority($flow_priority);

# # --- Instruction: 'Apply-action'
# #     Action:      'Drop'
my $instruction = $flowentry->add_instruction(0);
my $action = new Brocade::BSC::Openflow::Action::Drop(order => 0);
$instruction->apply_actions($action);

# # --- Match Fields: Ethernet Type
# #                   IPv4 Destination Address
my $match = new Brocade::BSC::Openflow::Match();
$match->eth_type($ethtype);
$match->ipv4_src($ipv4_src);
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

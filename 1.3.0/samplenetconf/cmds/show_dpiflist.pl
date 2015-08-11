#!/usr/bin/perl

use strict;
use warnings;

use Getopt::Long;
use Brocade::BSC;
use Brocade::BSC::Node::NC::Vrouter::VR5600;

my $configfile = "";

GetOptions("config=s" => \$configfile) or die ("Command line args");

my $bvc = new Brocade::BSC(cfgfile => $configfile);
my $vRouter = new Brocade::BSC::Node::NC::Vrouter::VR5600(cfgfile => $configfile,
                                                         ctrl => $bvc);

print "<<< 'Controller': $bvc->{ipAddr}, " .
    "'$vRouter->{name}': $vRouter->{ipAddr}\n";
my ($status, $iflist) = $vRouter->get_dataplane_interfaces_list();
$status->ok or die "Error: ${\$status->msg}\n";

print "Dataplane interfaces:\n";
print JSON->new->canonical->pretty->encode($iflist);

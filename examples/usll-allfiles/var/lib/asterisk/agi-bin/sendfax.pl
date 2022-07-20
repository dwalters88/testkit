#!/usr/bin/perl

#sendfax.pls - Generic fax sending AGI

#History
#-------
#20171030 DBW Original Version

#To Do
#------

use strict;
use warnings;

my $TEMPDIR	= "/tmp";
my $SPOOLDIR	= "/var/spool/asterisk/outgoing";
my $COVER	= "/etc/asterisk/+FAXTEST/cover.tiff";

my $to 		= $ARGV[0];
my $endpoint 	= $ARGV[1];
my $from 	= $ARGV[2];
my $image	= $ARGV[3];

system ("/usr/bin/tiffcp /etc/asterisk/+FAXTEST/cover.tiff /tmp/$image.tiff /tmp/$image-r.tiff");

my $outgoing =
   "Channel:  PJSIP/$to\@$endpoint\n"
   . "CallerID: FAX <$from>\n"
   . "WaitTime: 30\n"
   . "Maxretries: 1\n"
   . "RetryTime: 60\n"
   . "Account:  1000\n"
   . "Set:  tempfax=$image-r\n"
   . "Context:  USCA-utilities\n"
   . "Priority:  1\n"
   . "Extension:  send-t38-fax\n";

#print "[$outgoing]\n";


my $testpath = "$TEMPDIR/$image.out";
my $outpath  = "/var/spool/asterisk/outgoing/$image.out";
my $fh;

open ($fh,'>', "$testpath") || die "Cound not open file $testpath $!\n";
print $fh $outgoing;
close($fh);

open ($fh,'>', "$outpath") || die "Cound not open file $outpath $!\n";
print $fh $outgoing;
close($fh);

#!/usr/bin/perl -w
use strict;
use warnings;
use Term::ANSIColor;

my $time;

if(!defined($ARGV[0]))
{
    print "Log will be 5m old by default, you can change it when calling the script: ./getYourLogs.pl <nb min>, 0 <= <nb min> <= 59\n" ;
    $time = 5;
}else
{
    $time = $ARGV[0];
}

print "you ask your logs from more than 59m, you can't. It has been set to 59m automatically.\n" if($time > 59);
$time = 59 if($time > 59);

my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
my ($hourMin, $minMin) = ($hour, $min);

if ($min < $time) 
{
    $hourMin-- if ($hour > 1) or die ("Don't work that late");
    $minMin = 59 + $min - $time;
}else
{
    $minMin -= $time;
}

my ($hourMinBuffer, $minMinBuffer) = ($hourMin, $minMin);

open(DATA, "</var/log/httpd/error_log") or die ("couldn't open the logs file, check if the path is still ok");

my @lines = <DATA>;
my @linesToPush;

while ($hourMin != $hour || $minMin != $min)
{
    if($hourMin == $hour)
    {
        while($minMin != $min)
        {
            foreach my $line (@lines)
            {
                push(@linesToPush,  $line) if($line =~ m/$mday 0$hourMin:$minMin/ && $hourMin < 10);
                push(@linesToPush,  $line) if($line =~ m/$mday $hourMin:$minMin/ && $hourMin > 9);
            }         
            $minMin ++;
        }
    }else{
        while($minMin < 60)
        {
            foreach my $line (@lines)
            {
                push(@linesToPush,  $line) if($line =~ m/$mday 0$hourMin:$minMin/ && $hourMin < 10);
                push(@linesToPush,  $line) if($line =~ m/$mday $hourMin:$minMin/ && $hourMin > 9);
            }   
            $minMin ++;
        }
        $hourMin ++;
        $minMin = 0;
    }
}

print "\n";
foreach my $lineToPush(@linesToPush)
{
    TransformToPrint($lineToPush);
}
print "No logs since $hourMinBuffer:$minMinBuffer.\n" if(scalar(@linesToPush) == 0);
print "\n";

close DATA;

sub TransformToPrint
{
    my ($lineToPrint) = @_;
    my @tabLineToPrint = split(' ', $lineToPrint);
    for my $i (0 .. $#tabLineToPrint)
    {
        if ($i < 5)
        {
            print color 'bold blue';
            print "[" if($i == 0);
            print"] " if($i == 4);
            print "$tabLineToPrint[$i]" if($i == 3);
            print color 'reset';
        }elsif($i < 6){
            print color 'bold green';
            print "$tabLineToPrint[$i] ";
            print color 'reset';
        }elsif($i==$#tabLineToPrint){
            print ".\n";
        }else{
            print "$tabLineToPrint[$i] ";
        }
    }
}

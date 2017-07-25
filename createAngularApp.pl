#!/usr/bin/perl -w
use strict;
use warnings;
use Term::ANSIColor;

print color 'bold white';
print "\nPlease find below the different path of people/front.\n";
print color 'reset';
print color 'green';
system("ls -d wd/people/front/*");
print color 'bold white';
print "\nSelect your path, need to be as <wd/people/front/*> ";
print "(For more info about a path just use 'info<space><path>'): ";
print color 'yellow';
chomp(my $path = <STDIN>);
print color 'white';

$path = "/home/user/".$path;

while(!-e $path || $path !~ /front/)
{
    my @pathArray = split(' ', $path);
    
    if(scalar(@pathArray) == 1)
    {
        print color 'red';
        print "\nThe path you asked doesn't exist or is not conform.";
        print color 'white';
        print "\nSelect a new one: ";
        print "('info<space><path>' or <path> and need to be as <wd/people/front>): ";
        print color 'yellow';
        chomp($path = <STDIN>);
        print color 'white';
        $path = "/home/user/".$path;

        @pathArray = split(' ', $path);  
    }else
    {
        if(-e $pathArray[1])
        {
            print color 'reset';
            print color 'green';
            system("ls -d $pathArray[1]/*");
            print color 'bold white';
        }else
        {
            print "The path you asked doesn't exist.";
        }
        print "\nSelect your new path ";
        print "('info<space><path>' or <path>): ";
        print color 'yellow';
        chomp($path = <STDIN>);
        print color 'white';
        $path = "/home/user/".$path;

        @pathArray = split(' ', $path);        
    }
}

my $pathToPath = "..";
my @pathToPathArray = split('/', $path);

if(scalar(@pathToPathArray) > 6)
{
    for(my $i = 6; $i < scalar(@pathToPathArray); $i++)
    {
        $pathToPath = $pathToPath."/..";
    }
}

print "\nName of your app ('App' will be add at the end of this name): ";
print color 'yellow';
chomp(my $appName = <STDIN>);
print color 'white';

$appName = $appName."App";

print "\nHow many view/controllers would you like to create? ";
print color 'yellow';
chomp(my $nbViews = <STDIN>);
print color 'white';
while ($nbViews !~ m/\d+/)
{
    print color 'red';
    print "\nPlease pick a number: ";
    print color 'white';
    chomp ($nbViews = <STDIN>);
}
my %hashViews;
for(my $j=1; $j<=$nbViews; $j++)
{
    print "\nName of your view num. $j";
    print ", this one will be used as the default main path" if($j == 1);
    print ": ";
    print color 'yellow';
    chomp(my $viewBuffer = <STDIN>);
    print color 'white';
    $hashViews{$j} = $viewBuffer;
}

die "\nDirectory $appName already exit" if(-e $path."/".$appName);
system("mkdir $path/$appName");
system("mkdir $path/$appName/js");
system("mkdir $path/$appName/views");
system("mkdir $path/$appName/css");
system("touch $path/$appName/index.html");
system("touch $path/$appName/js/app.js");
system("touch $path/$appName/js/controllers.js");
foreach my $view (values(%hashViews))
{
    system("touch $path/$appName/views/$view.html");
}
system("touch $path/$appName/css/common.css");


### creation of the index.html ###
open (INDEX, ">$path/$appName/index.html") || die ("\nFile not reached.");

print INDEX "<!DOCTYPE html>\n";
print INDEX "<html data-ng-app=\"$appName\" lang='en'>\n";
print INDEX "\t<head>\n";
print INDEX "\t\t<title>$appName</title>\n";
print INDEX "\t\t<script src=\"$pathToPath/static/jquery/2.1.1/jquery-2.1.1.min.js\"></script>\n";
print INDEX "\t\t<script src=\"$pathToPath/static/angularjs/1.4.8/angular-loader.min.js\"></script>\n";
print INDEX "\t\t<script src=\"$pathToPath/static/angularjs/1.4.8/angular.min.js\"></script>\n";
print INDEX "\t\t<script src=\"$pathToPath/static/angularjs/1.4.8/angular-route.min.js\"></script>\n";
print INDEX "\t\t<script src=\"$pathToPath/static/angularjs/1.4.8/angular-sanitize.min.js\"></script>\n";
print INDEX "\t\t<script src=\"$pathToPath/static/bootstrap/3.3.0/js/bootstrap.min.js\"></script>\n";
print INDEX "\t\t<script src=\"$pathToPath/static/cryptojs/3.1.2/sha512.js\"></script>\n";
print INDEX "\t\t<script src=\"$pathToPath/static/ui-bootstrap/0.11.0/ui-bootstrap-tpls-0.11.0.min.js\"></script>\n";
print INDEX "\t\t<script src=\"js/app.js\"></script>\n";
print INDEX "\t\t<script src=\"js/controllers.js\"></script>\n\n";     
print INDEX "\t\t<link href=\"css/common.css\" rel=\"stylesheet\"/>\n";
print INDEX "\t\t<link href=\"$pathToPath/static/bootstrap/3.3.0/css/bootstrap.min.css\" rel=\"stylesheet\"/>\n";
print INDEX "\t</head>\n";
print INDEX "\t<body>\n";
print INDEX "\t\t<div class=\"ng-view container-fluid\">\n";
print INDEX "\t\t</div>\n";
print INDEX "\t</body>\n";
print INDEX "</html>\n";

close(INDEX);


### creation of the app.js ###
open (APP, ">$path/$appName/js/app.js") || die ("\nFile not reached.");

my $routeProvider = '$routeProvider';

print APP "angular.module('$appName', ['ngRoute'])\n";
print APP "\t.config(['$routeProvider', function($routeProvider) {\n";

print APP "\t\t$routeProvider.when('/$hashViews{1}', {\n";
print APP "\t\t\ttemplateUrl : 'views/$hashViews{1}.html',\n";
print APP "\t\t\tcontroller  : '$hashViews{1}Controller'\n";


while (my ($k, $v) = each(%hashViews))
{
    print APP "\t\t}).when('/$v', {\n" if($k != 1);
    print APP "\t\t\ttemplateUrl : 'views/$v.html',\n" if($k != 1); 
    print APP "\t\t\tcontroller  : '${v}Controller'\n" if($k != 1);
}
print APP "\t\t}).otherwise({\n";
print APP "\t\t\tredirectTo : '/$hashViews{1}'\n";
print APP "\t\t})\n";
print APP "\t}]);\n";

close(APP);


### creation of the controllers ###
open (CTRL, ">$path/$appName/js/controllers.js") || die ("\nFile not reached.");

my $scope = '$scope';

print CTRL "'use strict';\n\n";
print CTRL "angular.module('$appName', [])\n";
while (my ($k,$v) = each(%hashViews))
{
    print CTRL "\t.controller('${v}Controller', ['$scope', function($scope) {\n\n" if($k != $nbViews);
    print CTRL "\t}]),\n" if($k != $nbViews);
}
print CTRL "\t.controller('$hashViews{$nbViews}Controller', ['$scope', function($scope) {\n\n";
print CTRL "\t}]);\n";


close(CTRL);


### creation of the first viex ###
foreach my $view (values(%hashViews))
{
    open (VIEW, ">$path/$appName/views/${view}.html") || die ("\nFile not reached.");
    
    print VIEW "<div class=\"row\">\n\n";
    print VIEW "</div>";
    
    close(VIEW);
}

print color 'green';
print "\nYour app $appName has been well build!\n\n";
print "check it here: https://interne.ovh.net:56743/people/";
my $urlToBeExtend = 0;
foreach my $word (@pathToPathArray)
{
    print "$word/" if($urlToBeExtend == 1);
    $urlToBeExtend = 1 if($word eq "front");
}
print "$appName/#$hashViews{1}\n\n";

#!/usr/bin/perl -w
use strict;
use warnings;
use Term::ANSIColor;
use LWP::Simple;

print color 'bold white';
print "\nWelcome to the angular App creator. The app will be created on your desktop.\n";

# =======================================================================================
# TO KNOW WHICH FILES HAVE TO BE CREATING
# =======================================================================================
my $path = "/home/user";

print "\nName of your app ('App' will be add at the end of this name): \n";
print color 'yellow';
chomp(my $appName = <STDIN>);
print color 'white';

$appName = $appName."App";

print "\nHow many components would you like to create? \n";
print color 'yellow';
chomp(my $nbComponents = <STDIN>);
print color 'white';
while ($nbComponents !~ m/\d+/)
{
    print color 'red';
    print "\nPlease pick a number: ";
    print color 'white';
    chomp ($nbComponents = <STDIN>);
}
my %hashComponents;
for(my $j=1; $j<=$nbComponents; $j++)
{
    print "\nName of your component num. $j: \n";
    print color 'yellow';
    chomp(my $componentBuffer = lcfirst(<STDIN>));
    print color 'white';
    $hashComponents{$j}{"name"} = $componentBuffer;
    print "\nHow many views for your component $componentBuffer: \n";
    print color 'yellow';
    chomp(my $nbViews = <STDIN>);
    print color 'white';
    while ($nbViews !~ m/\d+/ || $nbViews<1)
    {
        print color 'red';
        print "\nPlease pick a number, superior or equal 1: \n";
        print color 'white';
        chomp ($nbViews = <STDIN>);
    }
    for(my $k=1; $k<=$nbViews; $k++)
    {
        print "\nName of your view num. $k: \n";
        print color 'yellow';
        chomp(my $viewBuffer = lcfirst(<STDIN>));
        print color 'white';
        $hashComponents{$j}{$k} = $viewBuffer;
    }
}

# =======================================================================================
# TO INSTANTIATE THE API CALLS
# =======================================================================================
print "\nWould you like to instantiate yours API calls? (print no or the number of root paths you would like): \n";
print color 'yellow';
chomp(my $nbRootPaths = <STDIN>);
print color 'white';
my %hashPaths;
if($nbRootPaths =~ m/\d+/ && $nbRootPaths >= 1)
{
    for(my $k=1; $k<=$nbRootPaths; $k++)
    {
        print "\nName of your the factory for the call on your root path num. $k: \n";
        print color 'yellow';
        chomp(my $namePathBuffer = ucfirst(<STDIN>));
        print color 'white';
        $hashPaths{$k}{"name"} = $namePathBuffer;
        print "\nHow many children paths for the factory $namePathBuffer: \n";
        print color 'yellow';
        chomp(my $nbChildrenPaths = <STDIN>);
        print color 'white';
        while ($nbChildrenPaths!~m/\d+/ || $nbChildrenPaths<1)
        {
            print color 'red';
            print "\nPlease pick a number, superior or equal 1: \n";
            print color 'white';
            chomp ($nbChildrenPaths = <STDIN>);
        }
        for(my $l=1; $l<=$nbChildrenPaths; $l++)
        {
            print "\nWrote the $l th children path of the factory $namePathBuffer.  (a path parameter as to be print with :param, like this: << /rootPath/path/:id >>): \n";
            print color 'yellow';
            chomp(my $childrenPathBuffer = <STDIN>);
            print color 'white';
            $hashPaths{$k}{$l}{"path"} = $childrenPathBuffer;
            print "\nName of the path. (ex: /api/contact can be: Contact or /api/contact/:id can be ContactById)\n";
            print color 'yellow';
            chomp(my $childrenNamePathBuffer = ucfirst(<STDIN>));
            print color 'white';
            $hashPaths{$k}{$l}{"name"} = $childrenNamePathBuffer;
            print "\nWhat method would you like for your path $childrenPathBuffer? (print each method in uppercase, separate with a space as << PUT GET POST DELETE>>)\n";
            print color 'yellow';
            chomp(my $methodToImplement = <STDIN>);
            print color 'white';
            my @methods = split(' ', $methodToImplement);
            if(grep {"GET" eq $_} @methods)
            {
                $hashPaths{$k}{$l}{"GET"} = 1;   
            }else
            {
                $hashPaths{$k}{$l}{"GET"} = 0;
            }
            if(grep {"POST" eq $_} @methods)
            {
                $hashPaths{$k}{$l}{"POST"} = 1;
            }else
            {
                $hashPaths{$k}{$l}{"POST"} = 0;
            }
            if(grep {"PUT" eq $_} @methods)
            {
                $hashPaths{$k}{$l}{"PUT"} = 1;
            }else
            {
                $hashPaths{$k}{$l}{"PUT"} = 0;
            }
            if(grep {"DELETE" eq $_} @methods)
            {
                $hashPaths{$k}{$l}{"DELETE"} = 1;
            }else
            {
                $hashPaths{$k}{$l}{"DELETE"} = 0;
            }
            $hashPaths{$k}{$l}{"pathParams"} = "";
            my @pathBreakDown = split('/', $childrenPathBuffer);
            foreach my $pathPiece (@pathBreakDown)
            {
                if($pathPiece =~ m/:/)
                {
                    $hashPaths{$k}{$l}{"pathParams"} = $hashPaths{$k}{$l}{"pathParams"}."$pathPiece ";
                }
            }
        }
    }
}

# =======================================================================================
# CREATION OF THE FILES
# =======================================================================================
die "\nDirectory $appName already exit" if(-e $path."/".$appName);
system("mkdir $path/$appName");

system("touch $path/$appName/index.html");
system("touch $path/$appName/app.config.js");
system("touch $path/$appName/app.module.js");

system("mkdir $path/$appName/js");
system("touch $path/$appName/js/bootstrap.js");
system("touch $path/$appName/js/jquery.js");
system("touch $path/$appName/js/angular.js");
system("touch $path/$appName/js/angular-route.js");
system("touch $path/$appName/js/angular-resource.js");

system("mkdir $path/$appName/css");
system("touch $path/$appName/css/common.css");
system("touch $path/$appName/css/bootstrap.css");

system("mkdir $path/$appName/img");

foreach my $component (keys(%hashComponents))
{
    system("mkdir $path/$appName/$hashComponents{$component}{'name'}");
    system("touch $path/$appName/$hashComponents{$component}{'name'}/$hashComponents{$component}{'name'}.component.js");
    system("touch $path/$appName/$hashComponents{$component}{'name'}/$hashComponents{$component}{'name'}.module.js");
    while (my ($k, $v) = each($hashComponents{$component}))
    {
        system("touch $path/$appName/$hashComponents{$component}{'name'}/$v.template.html") if ($k =~ m/\d+/);
    }
}

system("mkdir $path/$appName/core");
system("touch $path/$appName/core/core.module.js");
foreach my $rootPath (keys(%hashPaths))
{
    system("mkdir $path/$appName/core/$hashPaths{$rootPath}{'name'}");
    system("touch $path/$appName/core/$hashPaths{$rootPath}{'name'}/$hashPaths{$rootPath}{'name'}.factory.js");
    system("touch $path/$appName/core/$hashPaths{$rootPath}{'name'}/$hashPaths{$rootPath}{'name'}.module.js");
}

# =======================================================================================
# OPEN EACH FILE TO FILL IT UP
# =======================================================================================

#==========# DL ALL CDN FILES #==========#
#my $link = "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css";
#my $code = get($link) or die "cannot retrieve code\n";
#open (CSSBOOTSTRAP, ">css/bootstrap.css");
#    print CSSBOOTSTRAP "$code";
#close CSSBOOTSTRAP;

#my $link = "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js";
#my $code = get($link) or die "cannot retrieve code\n";
#open (JSBOOTSTRAP, ">js/bootstrap.js");
#    print JSBOOTSTRAP "$code";
#close JSBOOTSTRAP;

#my $link = "https://ajax.googleapis.com/ajax/libs/angularjs/1.5.6/angular.min.js";
#my $code = get($link) or die "cannot retrieve code\n";
#open (JSANG, ">js/angular.js");
#    print JSANG "$code";
#close JSANG;

#my $link = "https://ajax.googleapis.com/ajax/libs/angularjs/1.5.6/angular-route.min.js";
#my $code = get($link) or die "cannot retrieve code\n";
#open (JSANGROUTE, ">js/angular-route.js");
#    print JSANGROUTE "$code";
#close JSANGROUTE;

#my $link = "https://ajax.googleapis.com/ajax/libs/angularjs/1.5.6/angular-resource.min.js";
#my $code = get($link) or die "cannot retrieve code\n";
#open (JSANGRESOURCE, "js/angular-resource.js");
#    print JSANGRESOURCE "$code";
#close JSANGRESOURCE;

#my $link = "http://code.jquery.com/jquery-3.2.1.min.js";
#my $code = get($link) or die "cannot retrieve code\n";
#open (JSJQUERY, "js/jquery.js");
#    print JSJQUERY "$code";
#close JSJQUERY;

#==========# INDEX.HTML #==========#
open (INDEX, ">$path/$appName/index.html") || die ("\nFile not reached.");
    print INDEX "<!DOCTYPE html>\n";
    print INDEX "<html data-ng-app=\"$appName\">\n";
    print INDEX "\t<head>\n";
    print INDEX "\t\t<title>$appName</title>\n";
    print INDEX "\t\thref=\"img/favicon.ico\" type=\"image/x-icon\" rel=\"shortcut icon\"\n";

    print INDEX "\t\t<link href=\"css/common.css\">\n";
    print INDEX "\t\t<link href=\"css/bootstrap.css\">\n";

    print INDEX "\t\t<script src=\"js/bootstrap.js\"></script>\n";
    print INDEX "\t\t<script src=\"js/jquery.js\"></script>\n";
    print INDEX "\t\t<script src=\"js/angular.js\"></script>\n";
    print INDEX "\t\t<script src=\"js/angular-route.js\"></script>\n";
    print INDEX "\t\t<script src=\"js/angular-resource.js\"></script>\n";

    print INDEX "\t</head>\n";
    print INDEX "\t<body>\n";
    print INDEX "\t\t<div class=\"ng-view container-fluid\"></div>\n";

    print INDEX "\t\t<script src=\"app.module.js\"></script>\n";
    print INDEX "\t\t<script src=\"app.config.js\"></script>\n";

    print INDEX "\n\t\t<!-- CORE IMPORT -->\n";
    print INDEX "\t\t<script src=\"core/core.module.js\"></script>\n";
    foreach my $rootPath (keys(%hashPaths))
    {
        print INDEX "\t\t<script src=\"core/$hashPaths{$rootPath}{'name'}/$hashPaths{$rootPath}{'name'}.factory.js\"></script>\n";
        print INDEX "\t\t<srcipt src=\"core/$hashPaths{$rootPath}{'name'}/$hashPaths{$rootPath}{'name'}.module.js\"></script>\n";
    }
    print INDEX "\n\t\t<!-- COMPONENTS IMPORT -->\n";
    foreach my $component (keys(%hashComponents))
    {
        print INDEX "\t\t<script src=\"$hashComponents{$component}{'name'}/$hashComponents{$component}{'name'}.component.js\"></script>\n";
        print INDEX "\t\t<script src=\"$hashComponents{$component}{'name'}/$hashComponents{$component}{'name'}.module.js\"></script>\n";
    }
    print INDEX "\t</body>\n";
    print INDEX "</html>\n";
close(INDEX);

#==========# APP.CONFIG.JS #==========#
my $routeProvider = '$routeProvider';
my $locationProvider = '$locationProvider';
open (APPCONFIG, ">$path/$appName/app.config.js") || die ("\nFile not reached.");
    print APPCONFIG "'use strict';\n\n";
    print APPCONFIG "angular\n";
    print APPCONFIG "\t.module('$appName')\n";
    print APPCONFIG "\t.config(['$locationProvider', '$routeProvider',\n"; 
    print APPCONFIG "\t\tfunction($locationProvider, $routeProvider) {\n";
    print APPCONFIG "\t\t\t$locationProvider.hashPrefix('!');\n\n";

    foreach my $component (keys(%hashComponents))
    {
        print APPCONFIG "\t\t\t$routeProvider\n";
        print APPCONFIG "\t\t\t.when('$hashComponents{$component}{'name'}', {\n";
        print APPCONFIG "\t\t\t\ttemplate: '<$hashComponents{$component}{'name'}></$hashComponents{$component}{'name'}>'\n";
        print APPCONFIG "\t\t\t})\n";
    }

    print APPCONFIG "\t\t\t.otherwise('/');\n";
    print APPCONFIG "\t\t}\n";
    print APPCONFIG "\t]);\n";
close(APPCONFIG);

#==========# APP.MODULE.JS #==========#
open (APPMODULE, ">$path/$appName/app.module.js") || die ("\nFile not reached.");
    print APPMODULE "'use strict';\n\n";
    print APPMODULE "angular\n";
    print APPMODULE "\t.module('$appName', [\n";
    print APPMODULE "\t\t'ngRoute',\n";
    print APPMODULE "\t\t'core',\n";

    foreach my $component (keys(%hashComponents))
    {
        print APPMODULE "\t\t'$hashComponents{$component}{'name'}',\n";
    }

    print APPMODULE "\t]);";       
close(APPMODULE);

#==========# COMPONENT #==========#
foreach my $component (keys(%hashComponents))
{
    my $scope = '$scope';
    open (COMPOCOMPONENT, ">$path/$appName/$hashComponents{$component}{'name'}/$hashComponents{$component}{'name'}.component.js");
        print COMPOCOMPONENT "'use strict';\n\n";
        print COMPOCOMPONENT "angular\n";
        print COMPOCOMPONENT "\t.module('$hashComponents{$component}{'name'}')\n";
        while (my ($k, $v) = each($hashComponents{$component}))
        {
            print COMPOCOMPONENT "\t.component('$v', {\n"  if ($k =~ m/\d+/);
            print COMPOCOMPONENT "\t\ttemplateUrl: '/$hashComponents{$component}{'name'}/$v.template.html',\n"  if ($k =~ m/\d+/);
            print COMPOCOMPONENT "\t\tcontroller: ['$scope', "  if ($k =~ m/\d+/);
            foreach my $rootPath (keys(%hashPaths))
            {
                print COMPOCOMPONENT "'$hashPaths{$rootPath}{'name'}', "  if ($k =~ m/\d+/);
            }
            print COMPOCOMPONENT "\n"  if ($k =~ m/\d+/);
            print COMPOCOMPONENT "\t\t\tfunction $v.Controller($scope){\n"  if ($k =~ m/\d+/);
            print COMPOCOMPONENT "\t\t\t\tvar self = this;\n"  if ($k =~ m/\d+/);
            print COMPOCOMPONENT "\t\t\t}\n"  if ($k =~ m/\d+/);
        }
        print COMPOCOMPONENT "\t\t]\n";
        print COMPOCOMPONENT "\t});\n";   
    close(COMPOCOMPONENT);

    open (COMPOMODULE, ">$path/$appName/$hashComponents{$component}{'name'}/$hashComponents{$component}{'name'}.module.js");
        print COMPOMODULE "'use strict'\n\n";
        print COMPOMODULE "angular\n";
        print COMPOMODULE "\t.module('$hashComponents{$component}{'name'}', [\n";
        foreach my $rootPath (keys(%hashPaths))
        {
            my $module = lcfirst($hashPaths{$rootPath}{'name'});
            print COMPOMODULE "\t\t'core.$module',\n";
        }
        print COMPOMODULE "\t]);\n";    
    close(COMPOMODULE);
}

#==========# CORE #==========#
open (COREMODULE, ">$path/$appName/core/core.module.js");
    print COREMODULE "'use strict'\n\n";
    print COREMODULE "angular\n";
    print COREMODULE "\t.module('core', [\n";
    foreach my $rootPath (keys(%hashPaths))
    {
        my $module = lcfirst($hashPaths{$rootPath}{'name'});
        print COREMODULE "\t\t'core.$module',\n";
    }
    print COREMODULE "\t]);\n";    
close(COREMODULE);

use Data::Dumper qw(Dumper);
print"\n";
print Dumper \%hashComponents;
print "\n =========\n\n";
print Dumper \%hashPaths;

foreach my $rootPath (keys(%hashPaths))
{
    my $module = lcfirst($hashPaths{$rootPath}{'name'});
    my $http = '$http';
    my $resource = '$resource';

    open (COREPATHFACTORY, ">$path/$appName/core/$hashPaths{$rootPath}{'name'}/$hashPaths{$rootPath}{'name'}.factory.js");
        print COREPATHFACTORY "'use strict';\n\n";
        print COREPATHFACTORY "angular\n";
        print COREPATHFACTORY "\t.module('core.$module')\n";
        print COREPATHFACTORY "\t.factory('$hashPaths{$rootPath}{'name'}', ['$resource', '$http',\n";
        print COREPATHFACTORY "\t\tfunction($resource, $http){\n";
        print COREPATHFACTORY "\t\t\treturn $resource('', {}, {\n";
        foreach my $childPath (keys(%{$hashPaths{$rootPath}}))
        {
            if($childPath =~ m/\d+/ && $hashPaths{$rootPath}{$childPath}{"GET"} == 1)
            {
                print COREPATHFACTORY "\t\t\t\t'get$hashPaths{$rootPath}{$childPath}{'name'}': {\n";
                print COREPATHFACTORY "\t\t\t\t\tmethod: 'GET',\n"; 
                print COREPATHFACTORY "\t\t\t\t\tisArray: true,\n";
                print COREPATHFACTORY "\t\t\t\t\turl: '$hashPaths{$rootPath}{$childPath}{'path'}',\n";
                print COREPATHFACTORY "\t\t\t\t\tparams: {" if($hashPaths{$rootPath}{$childPath}{'pathParams'} ne ''); 
                my @params = split(/( :|:)/, $hashPaths{$rootPath}{$childPath}{'pathParams'});
                my $arobase = '@';
                foreach my $param (@params)
                {
                    print COREPATHFACTORY "$param: '$arobase$param', ";
                }
                print COREPATHFACTORY "},\n" if($hashPaths{$rootPath}{$childPath}{'pathParams'} ne '');
                print COREPATHFACTORY "\t\t\t},\n";
                
            }
            if($childPath =~ m/\d+/ && $hashPaths{$rootPath}{$childPath}{"POST"} == 1)
            {
                print COREPATHFACTORY "\t\t\t\t'post$hashPaths{$rootPath}{$childPath}{'name'}': {\n";
                print COREPATHFACTORY "\t\t\t\t\tmethod: 'POST',\n";
                print COREPATHFACTORY "\t\t\t\t\turl: '$hashPaths{$rootPath}{$childPath}{'path'}',\n";
                print COREPATHFACTORY "\t\t\t\t\tparams: {" if($hashPaths{$rootPath}{$childPath}{'pathParams'} ne '');
                my @params = split(/( :|:)/, $hashPaths{$rootPath}{$childPath}{'pathParams'});
                my $arobase = '@';
                foreach my $param (@params)
                {
                    print COREPATHFACTORY "$param: '$arobase$param', ";
                }
                print COREPATHFACTORY "},\n" if($hashPaths{$rootPath}{$childPath}{'pathParams'} ne '');
                print COREPATHFACTORY "\t\t\t},\n";
                
            }
            if($childPath =~ m/\d+/ && $hashPaths{$rootPath}{$childPath}{"PUT"} == 1)
            {
                print COREPATHFACTORY "\t\t\t\t'put$hashPaths{$rootPath}{$childPath}{'name'}': {\n";
                print COREPATHFACTORY "\t\t\t\t\tmethod: 'PUT',\n";
                print COREPATHFACTORY "\t\t\t\t\turl: '$hashPaths{$rootPath}{$childPath}{'path'}',\n";
                print COREPATHFACTORY "\t\t\t\t\tparams: {" if($hashPaths{$rootPath}{$childPath}{'pathParams'} ne '');
                my @params = split(/( :|:)/, $hashPaths{$rootPath}{$childPath}{'pathParams'});
                my $arobase = '@';
                foreach my $param (@params)
                {
                    print COREPATHFACTORY "$param: '$arobase$param', ";
                }
                print COREPATHFACTORY "},\n" if($hashPaths{$rootPath}{$childPath}{'pathParams'} ne '');
                print COREPATHFACTORY "\t\t\t},\n";
                
            }
            if($childPath =~ m/\d+/ && $hashPaths{$rootPath}{$childPath}{"DELETE"} == 1)
            {
                print COREPATHFACTORY "\t\t\t\t'delete$hashPaths{$rootPath}{$childPath}{'name'}': {\n";
                print COREPATHFACTORY "\t\t\t\t\tmethod: 'DELETE',\n";
                print COREPATHFACTORY "\t\t\t\t\turl: '$hashPaths{$rootPath}{$childPath}{'path'}',\n";
                print COREPATHFACTORY "\t\t\t\t\tparams: {" if($hashPaths{$rootPath}{$childPath}{'pathParams'} ne '');
                my @params = split(/( :|:)/, $hashPaths{$rootPath}{$childPath}{'pathParams'});
                my $arobase = '@';
                foreach my $param (@params)
                {
                    print COREPATHFACTORY "$param: '$arobase$param', ";
                }
                print COREPATHFACTORY "},\n" if($hashPaths{$rootPath}{$childPath}{'pathParams'} ne '');
                print COREPATHFACTORY "\t\t\t},\n";
                
            }
        }
        print COREPATHFACTORY "\t\t\t);\n";
        print COREPATHFACTORY "\t\t}\n";
        print COREPATHFACTORY "\t]);";
    close COREPATHFACTORY;

    open (COREPATHMODULE, ">$path/$appName/core/$hashPaths{$rootPath}{'name'}/$hashPaths{$rootPath}{'name'}.module.js");
        print COREPATHMODULE "'use strict'\n\n";
        print COREPATHMODULE "angular\n";
        print COREPATHMODULE "\t.module('core.$module', [\n";
        print COREPATHMODULE "\t\t'ngResource'\n";
        print COREPATHMODULE "\t]);\n";
    close COREPATHMODULE;
}

#use Data::Dumper qw(Dumper);
#print"\n";
#print Dumper \%hashComponents;
#print "\n =========\n\n";
#print Dumper \%hashPaths;

print color 'green';
print "\nYour app $appName has been well build!\n\n";
print color 'white';

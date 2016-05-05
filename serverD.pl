#!/usr/bin/perl -w
 
use Socket; # For constants like AF_INET and SOCK_STREAM
 
$| = 1;
 
$proto = getprotobyname('tcp');    #get the tcp protocol
 
# 1. create a socket handle (descriptor)
my($sock);
socket($sock, AF_INET, SOCK_STREAM, $proto) 
    or die "could not create socket : $!";
 
# 2. bind to local port 8888
$port = 8888;
bind($sock , sockaddr_in($port, INADDR_ANY))
    or  die "bind failed : $!";
 
listen($sock , 10);
print "Server is now listening ...\n";
 
#accept incoming connections and talk to clients
while(1)
{
    my($client);
    $addrinfo = accept($client , $sock);
     
    my($port, $iaddr) = sockaddr_in($addrinfo);
    my $name = gethostbyaddr($iaddr, AF_INET);
     
    print "Connection accepted from $name : $port \n";
     
    #send some message to the client
    print $client "Hello client how are you\n";
}
 
#close the socket
close($sock);
exit(0); 
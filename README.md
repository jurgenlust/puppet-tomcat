puppet-tomcat
=============

Puppet module for installing Tomcat 6 packages and creating Tomcat user
instances on Debian and Ubuntu. 

# Installation #

Clone this repository in /etc/puppet, but make sure you clone it as directory
'tomcat'.

# Usage #

The manifest in the tests directory shows how you can create Tomcat user
instances. For convenience, a Vagrantfile was also added, which starts a
Debian Squeeze x64 VM and applies the init.pp. When the virtual machine is ready,
you should be able to access the examples webapp at
[http://localhost:8180/example](http://localhost:8180/example) and a
second Tomcat instance at [http://localhost:8280/](http://localhost:8280/),
but this one will return a 404, since no webapp was installed.


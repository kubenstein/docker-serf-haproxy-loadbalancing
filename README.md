Docker Serf-HAProxy loadbalancing 
=============

Goal was to, using docker, create servers configuration that will dynamically discover and bind new web servers to haproxy.


Technologies:
-------
After few days of researching I decided to use:

* **HAProxy** as loadbalancer. Alternative was to use `nginx`, but over the Internet people recommend haproxy. Both are equally good I guess.
* **Serf** as discovery service. There are many other ways to do discovery, I found/tried:
  - SkyDNS - really nice solution based on DNS, but I needed to be notified about changes via push/event mechanism and not pulling dns records to see if change happened.
  - DockerGen - use Docker events api to see if new container appeared. I aimed in multi host solution.
  - Consul - internally uses serf, all extra features were not needed for my setup.
  - Etcd - key/val store - after finding serf I never actually play with etcd.
* **Nginx** as demo server. Just for simplicity to serve some static content and see if loadbalancing forwards requests properly.

Usage
-----
To setup everything run `start.sh` script. It will build and run all containers.


Use Cases
-----
Additionally I wrote a few more scripts:

`add_extra_servers.sh` - run 3 more web servers, that will be binded to loadbalancer.

`swap_servers.sh` - run 3 more web servers, that will be binded to loadbalancer and then stop all previously running servers.

`haproxy_error.sh` - nuke haproxy process. In few sec it will be up, due to supervisor process recovery feature.

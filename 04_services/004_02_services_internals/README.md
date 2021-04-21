# Resources
### Using Source IP
https://kubernetes.io/docs/tutorials/services/source-ip/


## Service IP Address
* All non-headless services have ClusterIp assigned to them
* ClusterIps are handed out form a pool of available ip addresses
* ApiServer handles the process of assigning ClusterIp to the service. After assigning the ip, ApiServer tells
the kubelet process about IPs as assigned to what services as well as the endpoints which back these services

## NAT (Network Address Translation)
https://www.youtube.com/watch?v=QBqPzHEDzvo
- Public ipv4 address are limited
- Our internet provider allocates a public ip for the router
- All the devices on the home network share the same public ip address, but have their own private
  ip address
- Private ip address have range 192.168.x.x, 10.x.x.x, or 172.16.0.0 - 172.31.255.255
- NAT translates the private ip to public(source to destination) and public to private(destination to source)
- NAT forwarding table contains list of internal ip address mappings which is used for IP translations

## Source NAT
Source NAT changes the source address in IP header of a packet. It may also change the source port in 
the TCP/UDP headers. The typical usage is to change a private (rfc1918) address/port into a public
address/port for packets leaving your network.

In K8S service terms it means "replacing the source IP on a packet; in this page, that usually means 
replacing with the IP address of a node."

## Destination NAT
Destination NAT changes the destination address in IP header of a packet. It may also change the 
destination port in the TCP/UDP headers.The typical usage of this is to redirect incoming packets 
with a destination of a public address/port to a private IP address/port inside your network.

In K8S terms it means "replacing the destination IP on a packet; in this page, that usually means 
replacing with the IP address of a Pod"

## Virtual IPs
https://kubernetes.io/docs/concepts/services-networking/service/#virtual-ips-and-service-proxies
A virtual IP address, such as the one assigned to every Service in Kubernetes

Every node in a Kubernetes cluster runs a kube-proxy. kube-proxy is responsible for implementing a form of 
virtual IP for Services of type other than ExternalName.

## kube-proxy
https://www.youtube.com/watch?v=nKKTdo2Yo6Y
* a network daemon that orchestrates Service VIP management on every node
* It watches all the services and endpoints
* It applies some filters like ignores the headless services
* It links the end points with services
* Combines endpoint and service information and update te rules on the node 



https://stackoverflow.com/a/36088688/440432

### Kube Proxy - Userspace mode 
Description
* It is responsible for watching each service and endpoint object associated with each object 
  and configure a proxier. 
* When client is trying to access the service using the Virtual IP, the proxier is responsible 
  for sending the traffic to actual pods
* Client connects to Kube-Proxy via iptable rules and then kube-proxy does the actual load balancing 
  to the pods
* 
 ---

### Kube Proxy - iptables
* In iptables mode we still us iptables, but here the traffic is not proxies via kube proxy, it is directly
sent from iptables to the backend nodes
* Kube-proxy will hook into pre-routing and output chain
* It will add a new chain called "KUBE-SERVICES"
* It will identity the service and will send to the appropriate service chain
* The more services you have, the more service chains you will have. With more services, your iptable 
  configuration will become complex
* In each service chain you will have one rule corresponding to each backend
* These rules for each backend are probability rules, and are used to send the traffic to the 
  backends randomly
* Finally, you have a chain for each endpoint of the service and it is used doing the DNAT i.e.
  replacing the service VIP with pod ip
*   

### Kube proxy - ipvs


### Kube proxy - core DNS
## iptables
http://linux-training.be/networking/ch14.html#:~:text=The%20nat%20table%20in%20iptables,they%20exit%20the%20OUTPUT%20chain.

## Endpoint
A simplified view of all the ips(of pods) backing a given service

##

Other Description
* Kublet runs on every node
* Kublet checks the health status of each pod and sends this information to API Server
* Endpoint Controller, keeps track of all the pods and services, and it will update the Endpoint 
  object of all the services based on all the pods matching a given label


## Data plane vs Control plane


# Other Vidoes

https://www.youtube.com/watch?v=BxDnv7MpJ0I

https://www.youtube.com/watch?v=H5Zl_kDOwBU

https://www.youtube.com/watch?v=InZVNuKY5GY

Very good basics video
https://www.youtube.com/watch?v=InZVNuKY5GY


# iptables -L -n -t nat

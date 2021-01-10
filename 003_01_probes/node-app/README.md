# What are Pods
Pod is a "co-located" group of containers abd represents a basic building block in Kubernetes. We don't
deploy containers individually, we always deploy pods of container/s 

# Why do we need Pods
## One vs Multiple Containers
* Containers are designed to run only a single process per container
* Disadvantages of running multiple processes in a container
    * You have to manage processes your self
    * If all processes write to standard output, it then difficult to separate the logs
    * Difficult to add logic to restart if one of the process dies


# Two individual containers vs two containers in a Pod

## Two individual containers
* Port mappings ad added to the host machine which makes it difficult to replicate since the post mappings 
need to be unique for each replica

## Two containers in a Pod
* Pods help provide the two containers running in the same Pod the 
same env as if they are running in the same pod . ???    
* Containers are partially isolated
    * Containers in a pod share the same Linux Namespace instead of each container having its own
    * Kubernetes achieves this by configuring Docker to not create separate namespaces
    * Containers run under the same Network and UTS namespace i.e. that share the same hostname
    * Containers run under the same IPC namespace and can communicate through IPC
    * Containers in the same Pod can also share the same PID namespace
* Port mappings are done to the pod making it easy to create replicas of the pods
* File systems of each container is isolated from the filesystem of other containers in the pod 
Questions
 - Do containers don't have separate namespace when running in pods?

# Pod Networking
When pod is create
* It gets its own namespace
* It gets its own virtual ethernet connection( --- does this refer to IP?)

A pod is like a host as it has IP address and a range of ports that it can be mapped to container pods.
IP of the pod is reachable from all other pods in k8s cluster

# When do you need multiple containers
* Backups
* Synchronizer
* Authentication Gateway
* Collecting and pushing the logs


# Connecting to Pod
* Using k8s port forward
`kubectl port-forward kubia-manual 8888:8080`
* Using services

 
# Using labels to organize pods
* Organizing pods and all other Kubernetes objects is done through labels
* ----- Show Kubernetes Pod file -------
* Listing pods with labels `kubectl get po -l app=admin-ui`

# Stopping and removing pods
*  Delete by name - `kubectl pod delete nginx`
*  Delete by label - `kubectl pod delete po -l env=dev`



Other Networking Concepts
* Every pod has an IP address
* 
https://unix.stackexchange.com/a/183722

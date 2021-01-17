## Why services?
* Pods are ephemeral
* Pods is assigned ip after it has been assigned a node and before its started
* Horizontal Scaling i.e. Multiple pods provide the same service

## What is service?
Service is a single constant point of entry to a group of nodes providing the same service.

e.g. image processing service

## Defining a Service


## Types of Services
### ClusterIP
### NodePort
### LoadBalancer
### ExternalName

## Service Discovery


## Services without pod selector
* Pointing to another cluster or namespace
* Pointing to external ip or domain
* You are in the migration process

## Endpoint Object

## Other
* Use names for port mappings
* Kubernetes supports multiple port definitions on a Service object

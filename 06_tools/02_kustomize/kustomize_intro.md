## Introduction
Kustomize lets you customize raw, template-free YAML files for multiple purposes, leaving the original YAML 
untouched and usable as is.

Kustomize is like Kubernetes, it is totally declarative ! You say what you want and the system provides it to you. 
You don’t have to follow the imperative way and describe how you want it to build the thing.

## Commands
To see what will be applied in your cluster, we will mainly use in the command `kustomize build` instead of `kubectl apply -k`.



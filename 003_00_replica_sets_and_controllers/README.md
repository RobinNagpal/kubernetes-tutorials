## Unmanaged Pod
* Created when we directly create a pod
* If the pod errors out and dies, the pod is restarted by Kubernetes
* Kubelet which runs in a node takes care of this
* If the node dies, the unmanaged pods running in the node are lost.

## What is Kubelet?
The kubelet is the primary "node agent" that runs on each node.

The kubelet takes a set of PodSpecs that are provided through various mechanisms 
(primarily through the apiserver) and ensures that the containers described in those 
PodSpecs are running and healthy. The kubelet doesn't manage containers which were 
not created by Kubernetes.



## Replication Controller
If the node fails, when pods are manages by Replication Controllers,
the pods are created in another healthy node. Replication Controller
makes sure the number of running pods match the replica count mentioned
in Replication Controller.

Relplication Controller chooses the pods based on label selectors


## Three parts of Replication Controller
* Label Selector
* Replica Count
* Pod Template

# Changing label selector of Replication Controller
* TRY AND SEE WHAT HAPPENS


## Other
* Pod isn't tied to Replication Controller, but it does contain the reference
to replication controller in `metadata.ownerReferences` field. This can be
used for debugging.
  
* Delete Replication Controller and not deleting the pods can be achieved by
`--cascade=false`

## Replication Sets

## Replication Sets vs Replication Containers
Replication sets provide more flexibility for selection of pods. Replication
Controllers only allow selection by certain label, Replica Set's selector allows
mathching pods that lack certain label or that include a certain label key.

Replication Contoller can match at just one label, not multiple

## Show above in exercise

## Replica Sets Label Selectors
1) In
2) NotIn
3) Exists
4) DoesNotExist

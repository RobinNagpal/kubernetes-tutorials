# EKS
* EKS automates most of the steps and allows you to get an EKS instance up and running in minutes by bringing up the 
  Kubernetes control plane (masters), assuming you already have your AWS IAM permissions and users configured correctly.
* EKS does not create nodes automatically when you create an instance, so you have to do that manually.


# KOPS
* Kops, on the other hand, lets you actually configure masters and nodes yourself. Yes, it works with AWS, but master 
  nodes are created as EC2 instances instead. The tool also supports automation during the setup process.
* You can update the kops templates at any time and it will take care of making the proper changes in AWS. 
  The kube infrastructure with kops is described through templates, so, you simply describe the desired state and kops 
  will work to match the kube environment to that.


# EKS vs KOPS
## Cluster Management
* With EKS, things such as managing the master node and configuring the cloud environment are handled by Amazon, leaving 
  you with little to no control over them.
* Kops, on the other hand, lets you configure your cloud environments the way you like them, including configuring them 
  to meet specific needs. Kops’s manual approach means you are completely responsible for making sure that the cluster 
  is configured correctly and running properly. You are also responsible for keeping the master nodes up to date and 
  working properly.

## Access Management and control
* Speaking of control and access management, by default, kops uses a secret (API bearer token) to authenticate users 
  but it has also added support for configuring authentication systems. Since Kops 1.10, the tool also supports AWS 
  IAM Authenticator (which is the way EKS authenticates). As mentioned before, EKS  relies on IAM for authenticating 
  users and the authorization is done by Kubernetes RBAC in the standard way. 

## Networking
* EKS uses the VPC CNI (network plugin) which gives each pod a VPC IP address and enables any pod to be able to 
  communicate with other AWS services without issues.

* Kops doesn’t have these advantages natively. To fully benefit from your use of kops, you need additional tools that 
  offer these functionalities. Also, kops uses private networking for pods by default and supports several CNIs for 
  pod networking, but AWS VPC CNI is not listed there.
  


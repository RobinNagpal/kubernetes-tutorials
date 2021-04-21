An Amazon EKS cluster consists of two primary components:
1) EKS Control Plane
2) EKS nodes


When you create a new cluster, Amazon EKS creates an endpoint for the managed 
Kubernetes API server that you use to communicate with your cluster (using 
Kubernetes management tools such as kubectl). By default, this API server endpoint 
is public to the internet, and access to the API server is secured using a 
combination of AWS Identity and Access Management (IAM) and native Kubernetes Role 
Based Access Control (RBAC).


## Cluster Configuration / Updates
- Create, Update or Delete a Cluster
- Amazon EKS cluster endpoint access control(Endpoint public access or 
  Endpoint private access)
- Cluster Autoscaler 
- Control plane logging

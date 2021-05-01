create_cluster:
	kops create -f cluster.yaml
	kops create secret --name kops.jomo.click sshpublickey admin -i ~/.ssh/id_rsa.pub
	kops update cluster kops.jomo.click --yes
	kops export kubecfg kops.jomo.click --admin

validate_cluster:
	kops validate cluster kops.jomo.click --wait 10m

delete_cluster:
	kops delete cluster kops.jomo.click --yes

edit_cluster:
	kops edit cluster kops.jomo.click --state=s3://kops-jomo-click-state-store

update_cluster:
	kops update cluster kops.jomo.click --yes

rolling_cluster_update:
	kops rolling-update cluster kops.jomo.click --instance-group-roles=Master --force --yes

list_clusters:
	kops get clusters

set_context:
	kops export kubecfg kops.jomo.click --admin

tf:
	terraform apply

aws_identity:
	aws sts get-caller-identity

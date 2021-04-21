create_cluster:
	kops create cluster kops.jomo.click --zones us-east-1a,us-east-1b  --state=s3://kops-jomo-click-state-store --yes

validate_cluster:
	kops validate cluster kops.jomo.click --wait 10m

delete_cluster:
	kops delete cluster kops.jomo.click --yes

edit_cluster:
	kops edit cluster kops.jomo.click --state=s3://kops-jomo-click-state-store

update_cluster:
	kops update cluster kops.jomo.click --state=s3://kops-jomo-click-state-store --yes

rolling_cluster_update:
	kops rolling-update cluster kops.jomo.click --instance-group-roles=Master --force --yes

list_clusters:
	kops get clusters

set_context:
	kops export kubecfg kops.jomo.click

tf:
	terraform apply

aws_identity:
	aws sts get-caller-identity

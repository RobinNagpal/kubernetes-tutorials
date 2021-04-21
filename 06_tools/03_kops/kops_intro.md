# Commands
`kops create cluster kops.jomo.click --zones us-east-1a,us-east-1b  --state=s3://kops-jomo-click-state-store --yes`

`kops validate cluster kops.jomo.click --wait 10m`

`kops delete cluster kops.jomo.click --yes`



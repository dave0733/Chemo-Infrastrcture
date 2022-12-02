#Create a service principal to access your resource group with the Contributor role using the following command,

Name="resourse_group_name"

az ad sp create-for-rbac \
    --name $Name \
    --scope /subscriptions/subscriptions_id/resourceGroups/resourse_group_name \
    --role Contributor \
    --sdk-auth
    
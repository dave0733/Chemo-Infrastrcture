#Create a service principal to access your resource group with the Contributor role using the following command,

Name="spiga_github_sp"

az ad sp create-for-rbac \
    --name $Name \
    --scope /subscriptions/e320cadf-67e8-4c2a-9a16-5db613904d7e/resourceGroups/spigaspaceshooter-rg \
    --role Contributor \
    --sdk-auth
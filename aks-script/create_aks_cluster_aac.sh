Resource_Group_Name="processes-rg"
Azure_Location="switzerlandnorth"

Vnet_Name="processes-vnet"
Subnet_Name="prod-aks-subnet"
Aks_Name="processes-aks"
Subnet_Id="/subscriptions/fa5ca116-3a38-426b-9228-d8974bb5dba0/resourceGroups/processes-rg/providers/Microsoft.Network/virtualNetworks/processes-vnet/subnets/prod-aks-subnet"
K8s_Version="1.22.4"
Node_Count=1
Vm_Size="Standard_B4ms"
Max_Number_of_Nodes=15
Max_Number_Of_Pods=250

az aks create -g $Resource_Group_Name -n $Aks_Name --network-plugin azure --vnet-subnet-id $Subnet_Id --docker-bridge-address 172.17.0.1/16 --dns-service-ip 10.100.0.10 --service-cidr 10.100.0.0/16 -k $K8s_Version -c $Node_Count --max-pods $Max_Number_Of_Pods -s $Vm_Size --generate-ssh-keys 
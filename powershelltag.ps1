$servicePrincipalAppId = "f74fb3f0-0c9f-410a-b0e0-d4e556265672"
$pscredential = Get-Credential -UserName $servicePrincipalAppId
Connect-AzureRmAccount  -Credential $pscredential -ServicePrincipal -TenantId "570057f4-73ef-41c8-bcbb-08db2fc15c2b"  -ErrorAction Stop
$resourceGroupName = "ms-workshop-posh-demo"
$location = "North Europe"
$vnetName = 'msworkshop-vnet-demo'
$tag = @{"msworkshop"="demo"}
$publicIpName = "rackspacemsworkshopdemo"
$dnsPrefix = "rackspacemsworkshopdemo1"
$storageaccountName = "rackspacedemostoragems"
$storageAccountNum = (1,2,3,4)

# Create resource group and a storage account
New-AzureRmResourceGroup -Name $resourceGroupName -Location $location
Write-Host "Creating Resource Group -->" $resourceGroupName -ForegroundColor Green

foreach ($item in $storageAccountNum) {
    $name = $storageaccountName+$item
    New-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $name -SkuName "Standard_LRS" -Location $location -ErrorAction "Stop"
    Write-Host "Creating storage account -->" $name -ForegroundColor Green
}

# Create a subnet 
$subnet = New-AzureRmVirtualNetworkSubnetConfig -Name 'frontendSubnet' `
    -AddressPrefix "10.0.1.0/24" 

# Create a vnet
$virtualNetwork = New-AzureRmVirtualNetwork `
  -ResourceGroupName $resourceGroupName `
  -Location $location `
  -Name $vnetName `
  -AddressPrefix 10.0.0.0/16 `
  -Tag $tag `
  -Subnet $subnet

Write-Host "Creating vnet -->" $vnetName -ForegroundColor Green
$virtualNetwork | Set-AzureRmVirtualNetwork

$publicIp = New-AzureRmPublicIpAddress -AllocationMethod Static -Name $publicIpName -ResourceGroupName $resourceGroupName -DomainNameLabel $dnsPrefix -Location $location -Tag $tag

Write-Host "Creating public ip -->" $resourceGroupName -ForegroundColor Green

Write-Host "Public IP is: " $publicIp.IpAddress.ToString()
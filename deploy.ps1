$servicePrincipalAppId = "f74fb3f0-0c9f-410a-b0e0-d4e556265672"
$pscredential = Get-Credential -UserName $servicePrincipalAppId
$resourceGroup = "ms-workshop-logic-app"
$location  = "North Europe"

Connect-AzureRmAccount  -Credential $pscredential -ServicePrincipal -TenantId "570057f4-73ef-41c8-bcbb-08db2fc15c2b"  -ErrorAction Stop

New-AzureRmResourceGroup -Name $resourceGroup -Location $location

New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroup -TemplateFile ./template.json -TemplateParameterFile ./parameters.json

$pscredential = Get-Credential -UserName $servicePrincipalAppId
Connect-AzureRmAccount  -Credential $pscredential -ServicePrincipal -TenantId "570057f4-73ef-41c8-bcbb-08db2fc15c2b"  -ErrorAction Stop

$resourceGroup = "ms-workshop-logic-app"
New-AzureRmResourceGroup -Name $resourceGroup -Location "North Europe"

New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroup -TemplateFile ./template.json -TemplateParameterFile ./parameters.json
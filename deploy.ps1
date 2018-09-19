$resourceGroup = "ms-workshop-logica-app"
New-AzureRmResourceGroup -Name $resourceGroup -Location "West Europe"

New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroup -TemplateFile ./template.json -TemplateParameterFile ./parameters.json
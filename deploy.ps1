$resourceGroup = "ms-workshop-logic-app"
New-AzureRmResourceGroup -Name $resourceGroup -Location "West Europe"

New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroup -TemplateFile ./template.json -TemplateParameterFile ./parameters.json
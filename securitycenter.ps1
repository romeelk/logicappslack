
$authUrl = "https://login.microsoftonline.com/570057f4-73ef-41c8-bcbb-08db2fc15c2b/oauth2/token"
$postParams = @{grant_type='client_credentials';client_id='f74fb3f0-0c9f-410a-b0e0-d4e556265672';
client_secret='pHvbMYQDXib7Evj/7h0qZeSG6ROwqWzDKTsJVM02GM4=';resource='https://management.core.windows.net'}

$response = Invoke-WebRequest `
-Uri  $authUrl `
-Headers $headers `
-Method "Post" `
-Body $postParams

$authObject = ConvertFrom-Json -InputObject $response.Content

$bearerToken = "Bearer " + $authObject.access_token

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add('Authorization',$bearerToken)

$securityApiRespones = Invoke-WebRequest `
-Uri  'https://management.azure.com/subscriptions/b4b92210-d397-4db6-9606-f19cfc40fda5/providers/Microsoft.Security/tasks?api-version=2015-06-01-preview' `
-Headers $headers `
-Method "Get"

$jsonString = ConvertFrom-Json -InputObject $securityApiRespones.Content

Write-Host "The following Security Center recommendations were found:" -ForegroundColor Yellow
foreach($compliance in $jsonString.value)
{
    $vmName = $(if($null -eq $compliance.properties.securityTaskParameters.vmName ) {"N/A"} Else{$compliance.properties.securityTaskParameters.vmName})
    Write-Host "VmName: $vmName Recommendation:" $compliance.properties.securityTaskParameters.name -ForegroundColor Green
}

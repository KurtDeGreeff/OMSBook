$WebhookURI = "https://s2events.azure-automation.net/webhooks?token=bg7P7iRzj7GNAFCUEtjrjMFBEWpFKsH42jC7Rvgxru8%3d"
$headers = @{"AuthorizationValue"="OMSBook"}

$WebhookBody  = @([pscustomobject]@{VMName="OMSVM";VMResourceGroup="OMS";VMLocation="West Europe"})
$body = ConvertTo-Json -InputObject $WebhookBody

$response = Invoke-WebRequest -Method Post -Uri $WebhookURI -Headers $headers -Body $body
$response 
$jobid = (ConvertFrom-Json ($response.Content)).jobids[0]
$jobid 
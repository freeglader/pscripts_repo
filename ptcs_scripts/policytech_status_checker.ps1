<##################################################################################################################################################################
#? PolicyTech S
#? Web servers 4, 5, and 6
#?
#?
#?
##################################################################################################################################################################>

# Avoid issues with TLS as PT rejects connections from anything less than TLS 1.2 
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"

[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}

$harvest = Invoke-WebRequest -Uri "https://dcole.5.policytech.com"

$harvest
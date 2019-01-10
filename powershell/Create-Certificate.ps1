<#
.Synopsis
This script generates self-signed certificates.
.Example
Create-Certificate -DNS example.com -YearsValid 3 - ExportPath "C:\Certificates\" -CertName MyCert -Password Password123
#>

# Configuration
[CmdletBinding()]
param(
    [Parameter(Mandatory=$True)]
    [string]$DNS,
    [Parameter(Mandatory=$True)]
    [int]$YearsValid,
    [Parameter(Mandatory=$True)]
    [string]$ExportPath,
    [Parameter(Mandatory=$True)]
    [string]$CertName,
    [Parameter(Mandatory=$True)]
    [string]$Password
)
# End of Configuration
 
$date_now = Get-Date
$extended_date = $date_now.AddYears($YearsValid)
$cert = New-SelfSignedCertificate -certstorelocation cert:\localmachine\my -dnsname $DNS -notafter $extended_date
$pwd = ConvertTo-SecureString -String $Password -Force -AsPlainText
$path = ‘cert:\localMachine\my\’ + $cert.thumbprint
$fullexportpath = $ExportPath + $CertName + '.pfx'
Export-PfxCertificate -cert $path -FilePath $fullexportpath -Password $pwd
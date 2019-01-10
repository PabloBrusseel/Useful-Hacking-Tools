# Configuration

$dns = 'example.com'
$yearsvalid = 10
$exportpath = 'C:\'
$certname = 'cert' + '.pfx'
$certpassword =  'password123'

# End of Configuration

$date_now = Get-Date
$extended_date = $date_now.AddYears($yearsvalid)
$cert = New-SelfSignedCertificate -certstorelocation cert:\localmachine\my -dnsname $dns -notafter $extended_date
$pwd = ConvertTo-SecureString -String $certpassword -Force -AsPlainText
$path = ‘cert:\localMachine\my\’ + $cert.thumbprint
$fullexportpath = $exportpath + $certname
Export-PfxCertificate -cert $path -FilePath $fullexportpath -Password $pwd
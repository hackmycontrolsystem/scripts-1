# *** DEVELOPED BY TREVOR BRYANT, PHACIL INC ***
# *** ps-newadusers.ps1 version 1.0.0, 02/20/2015 ***
# ***  USER MUST EXECUTE AS ADMININISTRATOR  ***

$stamp = (Get-Date -f HHmmss_MMddyyyy)
$date = ((Get-Date).AddDays(-1)).Date.ToString()
$loc = "Enter location to export data"

$smtp = "outlook.fqdn"
$to = "<ToEmail1@domain.com>", "<ToEmail2@domain.com>"
$cc = "<CCEmail1@domain.com>"
$user = $env:username + "@domain.com"
$from = $user -replace 'adm',''
$subject = "New AD users report - 1 day(s)"

$gUsers = Get-ADUser -LDAPFilter "(!(SamAccountName=$*))(Department=DEPT/*)" -Properties * | Select-Object SamAccountName,Enabled,GivenName,Surname,EmailAddress,OfficePhone,Department,Company,whenCreated
$gUsers | Export-CSV -NoTypeInformation $loc

$csv = Import-CSV $loc | Where-Object { $_.whenCreated -as [datetime] -ge "$date" } | ConvertTo-HTML -Fragment
$body = "New users created in Active Directory after $date. `n `n $csv `n `n Full report: $loc"

Send-MailMessage -BodyAsHtml -To $to -Cc $cc -Subject $subject -SmtpServer $smtp -From $from -Body $body

if ((Get-Date).DayofWeek -eq "Monday") {
    $subject = "New AD users report - 7 day(s)"
    $date = ((Get-Date).AddDays(-7)).Date.ToString()
    $csv = Import-CSV $loc | Where-Object { $_.whenCreated -as [datetime] -ge "$date" } | ConvertTo-HTML -Fragment
    $body = "New users created in Active Directory after $date. `n `n $csv `n `n Full report: $loc"
    Send-MailMessage -BodyAsHtml -To $to -Cc $cc -Subject $subject -SmtpServer $smtp -From $from -Body $body
    }
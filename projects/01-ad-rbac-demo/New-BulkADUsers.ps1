param(
    [Parameter(Mandatory=$true)][string]$CSVPath,
    [string]$DefaultPassword = "Passw0rd!"
)

Import-Module ActiveDirectory

$domain   = Get-ADDomain
$domainDN = $domain.DistinguishedName
$dnsRoot  = $domain.DNSRoot

$users = Import-Csv -Path $CSVPath
foreach ($u in $users) {

    # Expected OU names: Doctors, Nurses, IT under OU=Healthcare_Staff
    $ouDN = "OU=$($u.OU),OU=Healthcare_Staff,$domainDN"

    # SamAccountName fallback
    $sam = if ($u.SamAccountName) { $u.SamAccountName } else { ($u.FirstName.Substring(0,1) + $u.LastName).ToLower() }
    $upn = "$sam@$dnsRoot"

    $password = if ($u.Password) { $u.Password } else { $DefaultPassword }
    $secure   = ConvertTo-SecureString $password -AsPlainText -Force

    # Create user
    if (-not (Get-ADUser -Filter "SamAccountName -eq '$sam'" -ErrorAction SilentlyContinue)) {
        New-ADUser -Name "$($u.FirstName) $($u.LastName)" `
            -GivenName $u.FirstName -Surname $u.LastName `
            -SamAccountName $sam -UserPrincipalName $upn `
            -Path $ouDN -Enabled $true -AccountPassword $secure `
            -ChangePasswordAtLogon $true -Department $u.Department -Title $u.Title `
            -PassThru | Out-Null
        Write-Host "Created user: $sam"
    } else {
        Write-Host "User exists, skipping: $sam"
    }

    # Add to group if provided
    if ($u.Group) {
        try { Add-ADGroupMember -Identity $u.Group -Members $sam -ErrorAction Stop; Write-Host "  Added to $($u.Group)" }
        catch { Write-Warning $_.Exception.Message }
    }
}
Write-Host "Bulk user creation complete." -ForegroundColor Green

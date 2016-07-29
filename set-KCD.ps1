function set-KCD {
[cmdletbinding(SupportsShouldProcess=$True,ConfirmImpact='Medium')]

param (  
    [parameter(Mandatory=$True,ValueFromPipeline=$True)]
    $ADObject,

    [parameter(Mandatory=$True,ValueFromPipeline=$True)]
    [string[]]$SPNs
        )


if ($ADObject.AccountNotDelegated -eq $True) {
    $ADObject | Set-ADAccountControl -AccountNotDelegated $False -TrustedForDelegation $False -TrustedToAuthForDelegation $True
    }
else {
    $ADObject | Set-ADAccountControl -TrustedForDelegation $False -TrustedToAuthForDelegation $true
    }
foreach ($SPN in $SPNs) {
    $SPN= $SPN.toString()
    set-adObject -Identity $ADObject.distinguishedName -Add @{"msds-AllowedtoDelegateTo" = $SPN}
    write-verbose "Kerberos Constrained Delegation applied on $ADObject.sAMAccountName for $SPN."
    }
}
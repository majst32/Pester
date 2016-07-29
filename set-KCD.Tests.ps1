$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "set-KCD" {

    It "only allows a string to be passed to the SPNs parameter" {
    Mock Set-ADAccountControl {return $Null}
    Mock Set-ADObject {return $Null}

       { Set-KCD -ADObject Whatever -SPNs [pscustomobject]@{} } | Should Not Throw
    }
}

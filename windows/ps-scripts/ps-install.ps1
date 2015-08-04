#Simple script to copy and install software

$server = GC "C:\temp\hostlist"
$cred = Get-Credential

$server | foreach {
    Write-Host "$_ : Copying file and executing installation..."
    Copy-Item "C:\Users\Trevor\Downloads\software.exe" "\\$_\C$\temp" -Force
    Set-Content "\\$_\C$\temp\installme.bat" -Value "C:\temp\software.exe /q"
    Invoke-Command -CN $_ -Credential $cred -ScriptBlock { & cmd.exe /c "C:\temp\installme.bat" }
    Write-Host "$_ : Copy and installation complete."
}
$server
$error

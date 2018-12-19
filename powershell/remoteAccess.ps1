# Run this script with administrative privileges
Enable-PSRemoting -Force
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" –Value
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

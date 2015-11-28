# Background
These scripts were an immediate need for the customer based on DISA STIG specific requirements, it is also incomplete. There isn't any mapping (nor rhyme or reason for that matter) back to which requirement for DISA STIG requirement, but this was needed as a short and temporary solution so the analysts were out of servers that they really didn't need to be in, at least until an scanning agent was installed onto the server. If there's any interest I can come back and do this proper, but it's here for historical reasons.

## INSTRUCTIONS
1)	If the location does not exist, create C:\ps-scripts on the server to be scanned.
2)	Place the ps-isso-scans.zip into C:\ps-scripts and unzip to this location.
3)	Open Windows Powershell as Administrator
4)	Execute ps-isso.ps1 by entering "C:\ps-scripts\ps-isso.ps1" and pressing enter.
5)	Collect results and remove ALL the .ps1 scripts if they did not automatically get removed.
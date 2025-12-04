$url = "https://raw.githubusercontent.com/ansible/ansible-documentation/refs/heads/devel/examples/scripts/New-AnsiblePowerShellSignature.ps1"
$file = "$env:temp\ConfigureRemotingForAnsible.ps1"

(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)

powershell.exe -ExecutionPolicy ByPass -File $file
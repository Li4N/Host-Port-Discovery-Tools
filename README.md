# Custom finder tools
Available scripts for Linux & Windows systems

## Installation
```
git clone https://github.com/Li4N/Local-Host-Port-Discovery-Tools.git --depth 1
```

---

## Linux Usage
```
portDiscover.sh <IP> | hostDiscover.sh <RANGE IP as XX.XX.XX>

  E.g.: portDiscover.sh 127.0.0.1
  E.g.: hostDiscover.sh 127.0.0
```

---

## Windows Usage

> Requires **PowerShell 7+** for parallel scanning.  
> If blocked by ExecutionPolicy, run: `Set-ExecutionPolicy -Scope Process Bypass`

```powershell
.\portscan.ps1 -Target <IP> [-StartPort 1] [-EndPort 65535] [-Timeout 1000] [-Threads 100]
.\hostscan.ps1 <RANGE IP as XX.XX.XX>

  E.g.: .\portscan.ps1 -Target 127.0.0.1
  E.g.: .\portscan.ps1 -Target 127.0.0.1 -StartPort 1 -EndPort 1024 -Timeout 500 -Threads 200
  E.g.: .\hostscan.ps1 127.0.0
```

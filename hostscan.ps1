param(
    [Parameter(Mandatory=$false)]
    [string]$Range
)

if (-not $Range) {
    Write-Host "Uso: .\hostscan.ps1 <rango_base>"
    Write-Host "Ejemplo: .\hostscan.ps1 192.168.1"
    exit 0
}

Write-Host "[*] Escaneando $Range.1 - $Range.254 ..." -ForegroundColor Cyan

$jobs = 1..254 | ForEach-Object {
    $ip = "$Range.$_"
    Start-Job -ScriptBlock {
        param($ip)
        $result = Test-Connection -ComputerName $ip -Count 1 -Quiet -ErrorAction SilentlyContinue
        if ($result) {
            Write-Output "[+] HOST $ip - ACTIVE"
        }
    } -ArgumentList $ip
}

$jobs | ForEach-Object {
    $output = Receive-Job -Job $_ -Wait -AutoRemoveJob
    if ($output) { Write-Host $output -ForegroundColor Green }
}

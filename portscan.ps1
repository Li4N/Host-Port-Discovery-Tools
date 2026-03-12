param(
    [Parameter(Mandatory=$false)]
    [string]$Target,
    [int]$StartPort = 1,
    [int]$EndPort = 65535,
    [int]$Timeout = 1000,
    [int]$Threads = 100
)

if (-not $Target) {
    Write-Host "Uso: .\portscan.ps1 -Target <IP> [-StartPort 1] [-EndPort 1024] [-Timeout 500] [-Threads 100]"
    Write-Host "Ejemplo: .\portscan.ps1 -Target 192.168.1.1 -EndPort 1024"
    exit 0
}

Write-Host "[*] Escaneando $Target puertos $StartPort-$EndPort ..." -ForegroundColor Cyan

$ports = $StartPort..$EndPort
$results = [System.Collections.Concurrent.ConcurrentBag[string]]::new()

$ports | ForEach-Object -ThrottleLimit $Threads -Parallel {
    $port = $_
    $bag  = $using:results
    $ip   = $using:Target
    $tout = $using:Timeout

    try {
        $tcp = [System.Net.Sockets.TcpClient]::new()
        $async = $tcp.BeginConnect($ip, $port, $null, $null)
        $wait  = $async.AsyncWaitHandle.WaitOne($tout, $false)
        if ($wait -and $tcp.Connected) {
            $bag.Add("[+] ${ip}:${port} - OPEN")
        }
        $tcp.Close()
    } catch {}
}

$results | Sort-Object | ForEach-Object { Write-Host $_ -ForegroundColor Green }

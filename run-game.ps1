param([int]$Port = 8765)

$ErrorActionPreference = 'Stop'
$gameRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$pagePath = Join-Path $gameRoot 'index.html'
if (-not (Test-Path -LiteralPath $pagePath)) { throw "Game page not found: $pagePath" }

$listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Loopback, $Port)
$listener.Start()
$address = "http://127.0.0.1:$Port/"
Write-Host "Rail Network Builder is running at $address"
Write-Host 'Keep this window open while you play. Press Ctrl+C to stop the local game server.'
Start-Process $address

try {
    while ($listener.Server.IsBound) {
        $client = $listener.AcceptTcpClient()
        $reader = $null
        try {
            $stream = $client.GetStream()
            $reader = [System.IO.StreamReader]::new($stream, [System.Text.Encoding]::ASCII)
            $requestLine = $reader.ReadLine()
            while ($null -ne ($headerLine = $reader.ReadLine()) -and $headerLine.Length -gt 0) { }

            $parts = if ($requestLine) { $requestLine.Split(' ') } else { @() }
            $isPageRequest = $parts.Count -ge 2 -and $parts[0] -eq 'GET' -and ($parts[1] -eq '/' -or $parts[1] -eq '/index.html')
            if ($isPageRequest) {
                $body = [System.IO.File]::ReadAllBytes($pagePath)
                $status = '200 OK'
                $contentType = 'text/html; charset=utf-8'
            } else {
                $body = [System.Text.Encoding]::UTF8.GetBytes('Not found')
                $status = '404 Not Found'
                $contentType = 'text/plain; charset=utf-8'
            }

            $header = "HTTP/1.1 $status`r`nContent-Type: $contentType`r`nContent-Length: $($body.Length)`r`nCache-Control: no-store`r`nConnection: close`r`n`r`n"
            $headerBytes = [System.Text.Encoding]::ASCII.GetBytes($header)
            $stream.Write($headerBytes, 0, $headerBytes.Length)
            $stream.Write($body, 0, $body.Length)
            $stream.Flush()
        } finally {
            if ($reader) { $reader.Dispose() }
            $client.Close()
        }
    }
} finally {
    $listener.Stop()
}


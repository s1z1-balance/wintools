#Requires -Version 5.1

$originalBg = $Host.UI.RawUI.BackgroundColor
$originalFg = $Host.UI.RawUI.ForegroundColor

$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "Red"
Clear-Host

$tools = @(
    @{ Name = "Edge Remover";       Desc = "Uninstalls or reinstalls Microsoft Edge on Windows 10 & 11"; Cmd = "iex (irm 'https://raw.githubusercontent.com/he3als/EdgeRemover/main/get.ps1')" },
    @{ Name = "Remove Windows AI";  Desc = "Force remove Copilot, Recall and more";                      Cmd = "& ([scriptblock]::Create((irm 'https://raw.githubusercontent.com/zoicware/RemoveWindowsAI/main/RemoveWindowsAi.ps1')))" },
    @{ Name = "O&O ShutUp10++";     Desc = "The antispy tool for Windows 10 and 11";                     Cmd = 'curl.exe -sLo "$env:TEMP\OOSU10.exe" https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe; Start-Process "$env:TEMP\OOSU10.exe"' },
    @{ Name = "WinUtil (CTT)";      Desc = "Chris Titus Tech Windows Utility";                           Cmd = "iex (irm 'christitus.com/win')" },
    @{ Name = "Win11Debloat";       Desc = "Remove bloat, disable telemetry (Raphire)";                  Cmd = "& ([scriptblock]::Create((irm 'https://debloat.raphi.re/')))" },
    @{ Name = "MAS (Activation)";   Desc = "HWID/KMS38 open-source activator";                           Cmd = "irm https://get.activated.win | iex" },
    @{ Name = "Optimizer";          Desc = "Privacy and performance optimization utility";               Cmd = 'curl.exe -sLo "$env:TEMP\Optimizer.exe" -L https://github.com/hellzerg/optimizer/releases/latest/download/Optimizer.exe; Start-Process "$env:TEMP\Optimizer.exe"' }
)

function Write-Banner {
    $lines = @(
        "██╗    ██╗██╗███╗   ██╗████████╗ ██████╗  ██████╗ ██╗     ███████╗",
        "██║    ██║██║████╗  ██║╚══██╔══╝██╔═══██╗██╔═══██╗██║     ██╔════╝",
        "██║ █╗ ██║██║██╔██╗ ██║   ██║   ██║   ██║██║   ██║██║     ███████╗",
        "██║███╗██║██║██║╚██╗██║   ██║   ██║   ██║██║   ██║██║     ╚════██║",
        "╚███╔███╔╝██║██║ ╚████║   ██║   ╚██████╔╝╚██████╔╝███████╗███████║",
        " ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝   ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚══════╝",
        "",
        "[ WIN TOOLS v0.1 ]",
        "[ github.com/s1z1-balance/wintools ]"
    )

    $width = $Host.UI.RawUI.WindowSize.Width

    foreach ($l in $lines) {
        $pad = [Math]::Max(0, [Math]::Floor(($width - $l.Length) / 2))
        Write-Host (" " * $pad + $l) -ForegroundColor DarkRed
    }
    Write-Host ""
}

function Write-Separator {
    $width = $Host.UI.RawUI.WindowSize.Width
    Write-Host ("═" * $width) -ForegroundColor DarkRed
}

function Show-Menu {
    Clear-Host
    Write-Banner
    Write-Separator
    Write-Host "  SELECT TOOL" -ForegroundColor Red
    Write-Separator
    Write-Host ""

    for ($i = 0; $i -lt $tools.Count; $i++) {
        $num = $i + 1
        Write-Host "  [" -NoNewline -ForegroundColor DarkRed
        Write-Host "$num" -NoNewline -ForegroundColor Red
        Write-Host "]  " -NoNewline -ForegroundColor DarkRed
        Write-Host ("{0,-22}" -f $tools[$i].Name) -NoNewline -ForegroundColor White
        Write-Host "  $($tools[$i].Desc)" -ForegroundColor DarkGray
    }

    Write-Host ""
    Write-Separator
    Write-Host "  [" -NoNewline -ForegroundColor DarkRed
    Write-Host "0" -NoNewline -ForegroundColor Red
    Write-Host "]  " -NoNewline -ForegroundColor DarkRed
    Write-Host "Exit" -ForegroundColor DarkGray
    Write-Host ""
}

function Launch-Tool {
    param([int]$index)

    $tool = $tools[$index]

    Write-Host ""
    Write-Host "  >> Launching: " -NoNewline -ForegroundColor DarkRed
    Write-Host $tool.Name -ForegroundColor Red
    Write-Host "  >> Running in separate elevated window..." -ForegroundColor DarkGray
    Write-Host ""

    $encoded = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($tool.Cmd))

    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -EncodedCommand $encoded" -Verb RunAs

    Write-Host "  >> Window launched. Press any key to return..." -ForegroundColor DarkGray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

while ($true) {
    Show-Menu

    Write-Host "  > " -NoNewline -ForegroundColor Red
    $userInput = Read-Host

    if ($userInput -eq "0") {
        $Host.UI.RawUI.BackgroundColor = $originalBg
        $Host.UI.RawUI.ForegroundColor = $originalFg
        Clear-Host
        break
    }

    $parsed = 0
    if ([int]::TryParse($userInput, [ref]$parsed) -and $parsed -ge 1 -and $parsed -le $tools.Count) {
        Launch-Tool -index ($parsed - 1)
    } else {
        Write-Host ""
        Write-Host "  [!] Invalid input." -ForegroundColor DarkRed
        Start-Sleep -Seconds 1
    }
}
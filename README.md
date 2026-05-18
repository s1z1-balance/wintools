# WinTools

<div align="center">

```
██╗    ██╗██╗███╗   ██╗████████╗ ██████╗  ██████╗ ██╗     ███████╗
██║    ██║██║████╗  ██║╚══██╔══╝██╔═══██╗██╔═══██╗██║     ██╔════╝
██║ █╗ ██║██║██╔██╗ ██║   ██║   ██║   ██║██║   ██║██║     ███████╗
██║███╗██║██║██║╚██╗██║   ██║   ██║   ██║██║   ██║██║     ╚════██║
╚███╔███╔╝██║██║ ╚████║   ██║   ╚██████╔╝╚██████╔╝███████╗███████║
 ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝   ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚══════╝
```

**A minimal PowerShell launcher for trusted Windows debloat & privacy tools**

![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue?logo=powershell)
![Windows](https://img.shields.io/badge/Windows-10%20%7C%2011-0078D4?logo=windows)
![Version](https://img.shields.io/badge/version-0.1-red)
![License](https://img.shields.io/badge/license-GPL--v3-green)

</div>

---

## what is this

WinTools is a lightweight PowerShell TUI that consolidates the most popular Windows debloat, privacy, and cleanup tools into a single numbered menu. No installation, no dependencies — just run and pick a tool.

Each tool launches in its **own elevated PowerShell window**, so WinTools itself stays open and you can run multiple tools in sequence without re-running anything.

---

## tools included

| # | Tool | What it does |
|---|------|-------------|
| 1 | **Edge Remover** | Uninstalls or reinstalls Microsoft Edge on Windows 10 & 11 |
| 2 | **Remove Windows AI** | Force-removes Copilot, Recall, and related AI components |
| 3 | **O&O ShutUp10++** | GUI antispy tool — granular control over Windows telemetry |
| 4 | **WinUtil (CTT)** | Chris Titus Tech's all-in-one Windows utility |
| 5 | **Win11Debloat** | Removes bloatware and disables telemetry (by Raphire) |

---

## usage

### one-liner (run directly from PowerShell as admin)

```powershell
irm https://raw.githubusercontent.com/s1z1-balance/wintools/main/WinToolsLauncher.ps1 | iex
```

### manual

```powershell
git clone https://github.com/s1z1-balance/wintools.git
cd wintools
powershell -ExecutionPolicy Bypass -File WinToolsLauncher.ps1
```

> **Admin rights are required.** Each tool spawns an elevated window automatically via `Start-Process -Verb RunAs`.

---

## how it works

```
WinToolsLauncher.ps1
│
├── Shows a numbered menu (TUI, black/red theme)
├── Reads your input
└── Launches selected tool
        └── Encodes the tool's command as Base64
            └── Spawns: powershell.exe -EncodedCommand ... -Verb RunAs
```

No tool command is hardcoded into the process — each is base64-encoded at runtime and passed to a fresh elevated shell. WinTools itself is just a launcher.

---

## requirements

- Windows 10 or Windows 11
- PowerShell 5.1+
- Internet connection (tools are fetched from their official sources)

---

## disclaimer

WinTools does not host or modify any of the included tools. Each tool is fetched directly from its official GitHub repository or website at runtime. Review what each tool does before running it — some make irreversible system changes.

All tools are run under **your** admin privileges. WinTools takes no responsibility for system changes made by third-party tools.

---

## adding your own tools

Open `WinToolsLauncher.ps1` and add an entry to the `$tools` array:

```powershell
$tools = @(
    # existing tools...
    @{ Name = "Your Tool"; Desc = "Short description"; Cmd = "your-powershell-command-here" },
)
```

That's it.

---

## contributing

Want to suggest a tool or improve the launcher? PRs are welcome.

### guidelines for adding a tool

- the tool must be **open source** with a public GitHub repository
- it must be fetched from its **official source** — no mirrors, no repacks
- the `Cmd` must be a single self-contained PowerShell expression (same pattern as existing entries)
- keep `Name` under ~20 chars and `Desc` short — it's a TUI, not a wiki

### steps

```
1. fork the repo
2. add your entry to the $tools array in WinToolsLauncher.ps1
3. test it locally — make sure the tool launches correctly in an elevated window
4. open a PR with a short description of what the tool does and a link to its repo
```

if you're not sure whether a tool fits, open an issue first.

---

<div align="center">
<sub>v0.1 — github.com/s1z1-balance/wintools</sub>
</div>

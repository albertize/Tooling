function Get-GitBranch {
    try {
        $branch = (git rev-parse --abbrev-ref HEAD 2>$null).Trim()
        if ($LASTEXITCODE -eq 0 -and -not [string]::IsNullOrEmpty($branch)) {
            return "git:" + $branch
        }
    }
    catch { }
    return ""
}

function prompt {
    if ($PSStyle) {
        $green = $PSStyle.Foreground.Green
        $reset = $PSStyle.Reset
    }
    else {
        $green = ""
        $reset = ""
    }
    $currentUser = ([Environment]::UserName)
    $currentFolder = Split-Path -Path (Get-Location).Path -Leaf
    $currentFolder = $currentFolder -replace "$currentUser", "~"
    $gitBranch = Get-GitBranch
    if (-not [string]::IsNullOrEmpty($gitBranch)) {
        $promptString = "[$green$gitBranch$reset] "
    }
    $promptString += "$green$currentUser$reset`:$green$currentFolder$reset"
    $promptString += ">"
    Write-Host $promptString -NoNewline
    return " "
}

# --- Coreutils Rust Configurations (uutils) ---

$uutils_commands = @(
    "arch", "b2sum", "base32", "base64", "basename", "basenc", "cat", "cksum", "comm", "cp", "csplit", "cut", "date",
    "dd", "df", "dir", "dircolors", "dirname", "du", "echo", "env", "expand", "expr", "factor", "false", "fmt", "fold",
    "hashsum", "head", "hostname", "join", "link", "ln", "ls", "md5sum", "mkdir", "mktemp", "more", "mv", "nl", "nproc",
    "numfmt", "od", "paste", "pr", "printenv", "printf", "ptx", "pwd", "readlink", "realpath", "rm", "rmdir", "seq",
    "sha1sum", "sha224sum", "sha256sum", "sha384sum", "sha512sum", "shred", "shuf", "sleep", "sort", "split", "sum",
    "sync", "tac", "tail", "tee", "test", "touch", "tr", "true", "truncate", "tsort", "uname", "unexpand", "uniq", "unlink",
    "vdir", "wc", "whoami", "yes"
)

foreach ($cmd in $uutils_commands) {
    # 1. Rimuove l'alias se esiste
    if (Test-Path "alias:$cmd") {
        Remove-Item "alias:$cmd" -Force -ErrorAction SilentlyContinue
    }

    # 2. Crea la funzione usando un blocco di script dinamico
    $condition = [scriptblock]::Create("coreutils $cmd `$args")
    New-Item -Path "Function:\$cmd" -Value $condition -Force | Out-Null
}

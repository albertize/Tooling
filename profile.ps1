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

New-Alias vi vim.exe

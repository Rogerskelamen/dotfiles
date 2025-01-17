# This file could be traced by calling env variable $PROFILE

# export proxy
$Env:http_proxy="http://127.0.0.1:7890";$Env:https_proxy="http://127.0.0.1:7890"

# export default command line app
$Env:EDITOR="nvim"
$Env:PAGER="less"
# Enable yazi to recognize files on Windows
$Env:YAZI_FILE_ONE="C:\Program Files\Git\usr\bin\file.exe"

# Enable oh-my-posh and config it
oh-my-posh init pwsh --config "$Env:POSH_THEMES_PATH/catppuccin.omp.json" | Invoke-Expression

# Modules
Import-Module Terminal-Icons

# go env
$Env:CGO_ENABLED=0
$Env:GOPATH="D:\programs\go"

##
### 设置PSReadLine
##
# 启用预测文本
Set-PSReadLineOption -PredictionSource History
# Set Vi Edit mode
Set-PSReadLineOption -EditMode Vi
# 设置Tab键补全
Set-PSReadlineKeyHandler -Key Tab -Function Complete
# 设置 Ctrl+d 为菜单补全和 Intellisense
Set-PSReadLineKeyHandler -Key "Ctrl+m" -Function MenuComplete
# 设置 Ctrl+z 为撤销
Set-PSReadLineKeyHandler -Key "Ctrl+z" -Function Undo
# 设置向上键为后向搜索历史记录
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
# 设置向下键为前向搜索历史纪录
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# 'which' command similar to Linux
function which
{
    $results = New-Object System.Collections.Generic.List[System.Object];
    foreach ($command in $args)
    {
        $path = (Get-Command $command).Source
        if ($path)
        {
            $results.Add($path);
        }
    }
    return $results;
}

##
### Alias
##
Set-Alias n winfetch
Set-Alias lg lazygit

# A better way to use yazi(change directory when exit)
function ra {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
}


# Enable zoxide(auto jump tool)
Invoke-Expression (& { (zoxide init powershell | Out-String) })

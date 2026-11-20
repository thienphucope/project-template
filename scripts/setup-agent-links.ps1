# Tạo Directory Junction .claude/skills -> .agents/skills (Windows, không cần quyền Admin)
$repoRoot = Split-Path -Parent $PSScriptRoot
$agentsSkills = Join-Path $repoRoot '.agents\skills'
$claudeDir = Join-Path $repoRoot '.claude'
$claudeSkills = Join-Path $claudeDir 'skills'

if (-not (Test-Path $agentsSkills)) {
    throw "Không tìm thấy $agentsSkills"
}

New-Item -ItemType Directory -Force -Path $claudeDir | Out-Null

if (Test-Path $claudeSkills) {
    $item = Get-Item $claudeSkills -Force
    if ($item.LinkType -eq 'Junction') {
        Write-Output "Đã có junction: $claudeSkills -> $($item.Target)"
        exit 0
    }
    throw "$claudeSkills đã tồn tại nhưng không phải Junction. Hãy kiểm tra và xử lý thủ công trước."
}

New-Item -ItemType Junction -Path $claudeSkills -Target $agentsSkills | Select-Object Name, LinkType, Target

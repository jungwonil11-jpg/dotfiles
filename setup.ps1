# 새 컴퓨터에서 딱 한 번 실행
$target = "$env:USERPROFILE\.claude\commands"
New-Item -ItemType Directory -Force $target | Out-Null
Copy-Item "$PSScriptRoot\.claude\commands\*" $target -Force
Write-Output "완료: $target 에 커맨드 복사됨"

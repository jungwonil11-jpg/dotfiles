# 새 컴퓨터에서 딱 한 번 실행 (또는 레포 업데이트 후)
$target = "$env:USERPROFILE\.claude\skills"
New-Item -ItemType Directory -Force $target | Out-Null
Copy-Item "$PSScriptRoot\.claude\skills\*" $target -Recurse -Force
Write-Output "완료: $target 에 skill 복사됨"

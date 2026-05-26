# Kill any stale bun processes before starting
taskkill /F /IM bun.exe 2>$null
Start-Sleep -Seconds 1

$env:TELEGRAM_STATE_DIR = "E:\Claude-Code\ExpertPro\.claude\channels\telegram"
claude --channels plugin:telegram@claude-plugins-official

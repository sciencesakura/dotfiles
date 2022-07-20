function Prompt
{
  if ($IsWindows)
  {
    Write-Host $env:USERNAME -NoNewline -ForegroundColor Yellow
  }
  else
  {
    Write-Host $env:USER -NoNewline -ForegroundColor Yellow
  }
  Write-Host '@' -NoNewline
  Write-Host ([System.Environment]::MachineName) -NoNewline -ForegroundColor Green
  return " PS> "
}

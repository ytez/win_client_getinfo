$ProfList=(netsh.exe wlan show profiles) -match ':'

For ($x=1; $x -lt $ProfList.count; $x++)
{
  $ProfName = ($ProfList[$x] -replace "^[^:]*: ([^:]+)","`$1")
  netsh.exe wlan show profiles name="$ProfName" key=clear
}

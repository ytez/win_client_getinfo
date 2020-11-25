Get-WmiObject -Class Win32_IP4RouteTable | Where-Object {
         $_.destination -eq '0.0.0.0' `
    -and $_.mask        -eq '0.0.0.0'
} | 
Sort-Object metric1 | 
Select-Object nexthop, metric1, interfaceindex | 
ForEach-Object {
  $msg = ('# PING to default route "{0}"' -f $_.nexthop);
  [Console]::Error.WriteLine($msg);
  Write-Output $msg;
  ping.exe -w 2000 -n 2 $_.nexthop;
}

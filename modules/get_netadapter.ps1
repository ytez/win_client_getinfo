$OutputEncoding = [Console]::OutputEncoding

Get-NetAdapter | 
Select-Object `
   InterfaceAlias `
  ,InterfaceDescription `
  ,MtuSize `
  ,InterfaceIndex `
  ,MacAddress `
  ,AdminStatus `
  ,Status `
  ,LinkSpeed `
  ,MediaType `
  ,DriverInformation `
  ,DriverFileName |
ConvertTo-Csv | 
Select-Object -Skip 1

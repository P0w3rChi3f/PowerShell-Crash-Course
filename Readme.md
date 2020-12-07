# Notes  

commands to add  

Get mac and IPaddress

```pwsh
Get-CimInstance Win32_NetworkAdapterConfiguration | Select-Object -Property @{name='IPaddress'; expression={($_.IPAddress[0])}}, MACAddress | Where IPAddress -ne $null
```  

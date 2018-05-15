
try {
<#
$res = Test-Connection 10.0.10.5 -count 6 -ErrorAction Stop | ft @{Name='address';Expr={$_.address};width=10},
                                        @{Name='ipv4address';Expr={$_.ipv4address};width=12},
                                        @{Name='responsetime';Expr={$_.responsetime};width=15} 
                                        #>
Test-Connection 10.0.10.5 -count 6 | if(Select-Object -Property Address,ResponseTime,StatusCode 
#Test-Connection 8.8.8.8 -count 6 | % {Write-Host "Reply from $($_.IPV4Address): bytes=$($_.BufferSize) time=$($_.ResponseTime) TTL=$($_.ResponseTimeToLive)"}
} catch [System.Net.NetworkInformation.PingException]  {
  write-output 'request timed out'
}



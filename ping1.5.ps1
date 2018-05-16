
try {
<#
$res = Test-Connection 10.0.10.5 -count 6 -ErrorAction Stop | ft @{Name='address';Expr={$_.address};width=10},
                                        @{Name='ipv4address';Expr={$_.ipv4address};width=12},
                                        @{Name='responsetime';Expr={$_.responsetime};width=15} 
                                        #>
Test-Connection 8.8.8.8 -count 6 | Select-Object -Property Address,ResponseTime,StatusCode
#Test-Connection 8.8.8.8 -count 6 | % {Write-Host "Reply from $($_.IPV4Address): bytes=$($_.BufferSize) time=$($_.ResponseTime) TTL=$($_.ResponseTimeToLive)"}
} catch [System.Net.NetworkInformation.PingException]  {
  write-output 'request timed out'
}

<#
clear
<#
$Error.Clear()
Test-Connection 10.0.10.5, 8.8.8.8 -ea 0 | %{if($Error.Count -gt 0){
        Write-Host "Request Time Out" 
        $Error.Clear()
        $Error.Count
    }Else{
        "Reply from $($_.IPV4Address): bytes=$($_.BufferSize) time=$($_.ResponseTime) TTL=$($_.ResponseTimeToLive)"
   }
}
#>
<#
#Test-Connection 8.8.8.8,10.0.10.5 -ea 2 | %{$Error.Count}
$Output_arr = @()
#Test-Connection 10.0.10.5 -Count 4| %{$_;$Output_arr += $_} Get-Member
Test-Connection 8.8.8.8 -Count 1 |  Get-Member
$Output_arr
#>



<#
 .Note
    Author : Rafael,kun,Vincent
    Version : 2.0.0
    Code Refactory 
#>
# ping machine class used for obtaining test-connnection cmdlet output
Class PingMachine{
  # class property
  # "Test-Connection $ip -Count 1 -ea 0 -Delay 10| Get-Member" to get more Test-Connection out put property
    [String]$Number_Success
    [String]$Number_Fail
    [String]$Number_Packet
    [String]$Ping_Statistic
    [String[]]$Ping_Result
    # Networking Connection Testing function
    TestConnection([string[]]$IP_Array) {
    $Output_arr = @()
    try{
        While($true){
            foreach($ip in $IP_Array){
                $time = "$(Get-Date -format "dd-MM-yyyy HH:mm:ss")"
                $Output = Test-Connection $ip -Count 1 -ea 0 -Delay 10| %{"Reply from $($_.IPV4Address): bytes=$($_.BufferSize) time=$($_.ResponseTime) TTL=$($_.ResponseTimeToLive)"}
                if($Output){
                    $File_content = "$Output $time"
                    Write-Host $File_content
                    $Output = ''
                }Else{
                    $File_content = "$ip bad  $time"
                    Write-Host $File_content
                }
                $Output_arr += $File_content
                #time out command
                start-sleep -Seconds 2
            }
        }
      }finally{
        $this.Ping_Result = $Output_arr
      }
    }
}

# handling writing ping out into text file
Function WriteFile([string[]]$Result){
    $Print = Read-Host -Prompt "Print Reult in Text File (Y/N) "
    if($Print.ToUpper() -eq 'Y'){
        $FileName = Read-Host -Prompt "Enter File Name "
        $OutputFile = (Get-Location).Path + "\$FileName.txt"
        try{
            $IO = [System.IO.StreamWriter] $OutputFile
            for ($i=0; $i -lt $Output_arr.Length;$i++){
                $IO.WriteLine($Output_arr[$i])
            }
            $IO.close()
        }finally{}
    }

}

<#
function TestConnection([string[]]$IP_Array) {
    $Output_arr = @()
    try{
        While(1){
            foreach($ip in $IP_Array){
                $time = "$(Get-Date -format "dd-MM-yyyy HH:mm:ss")"
                $Output = Test-Connection $ip -Count 1 -ea 0 -Delay 10| %{"Reply from $($_.IPV4Address): bytes=$($_.BufferSize) time=$($_.ResponseTime) TTL=$($_.ResponseTimeToLive)"}
                if($Output){
                    $File_content = "$Output $time"
                    Write-Host $File_content
                    $Output = ''
                }Else{
                    $File_content = "$ip bad  $time"
                    Write-Host $File_content
                }
                $Output_arr += $File_content
                start-sleep -Seconds 2
            }
         #start-sleep -seconds 2
        }
      }finally{

      }

}
#>

#need some input function
$IP_Array = @("10.0.10.5","8.8.8.8","10.0.10.4")
$ping = New-Object PingMachine
try{
    $ping.TestConnection($IP_Array)
}finally{
    Write-Host "Result array: $($ping.Ping_Result[1])"
    WriteFile($ping.Ping_Result[1])
}

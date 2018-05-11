<#
 .Note
    Author : Rafael,kun,Vincent
    Version : 1.0.1
    Array problem fixed, Text file print properly.
#>
Clear
$IP = Read-Host -Prompt 'Ping'
$Attemp = Read-Host -Prompt 'Times of Attemp'
$Output_arr = @()
While ($Attemp -gt 0){
   $time += 1
    if((Test-Connection -computer $IP -Delay 1 -quiet)){
        $Succeed += 1        
        $Output = "$time . $(Get-Date -format "dd-MM-yyyy HH:mm:ss"): $IP Successful Connected!"
        Write-Host -ForegroundColor Green "$Output"
    }Else {
        $Failure += 0
        $Output = "$time . $(Get-Date -format "dd-MM-yyyy HH:mm:ss"): $IP Unable to Connected!"
        Write-Host -ForegroundColor Red "$Output"
    }
     $Output_arr += $Output
     $Attemp -= 1
}
Write-Host "Testing Completed !"
Write-Host -ForegroundColor Green "Times of Succeed: $Succeed" 
Write-Host -ForegroundColor Red "Times of Failure: $Failure "
$Output_arr

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

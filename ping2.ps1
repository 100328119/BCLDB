Function Test-ConnectionAdvanced([string[]]$ComputerName)
{
    Begin{
        $ErrorActionPreference = 'SilentlyContinue'
    }
    Process{
        foreach($Computer in $ComputerName){
            Try{
                $TestConnection = Test-Connection $Computer -count 1 -Delay 6
            }
            Catch{
                $_
            }
            if($Error.Count -gt 0){
                [PSCustomObject]@{
                    TimeStamp = Get-Date
                    Address = $Computer
                    ResponseTime = 'N/A'
                    Success = $False
                }
            }else{
                [PSCustomObject]@{
                    TimeStamp = Get-Date
                    Address = $Computer
                    ResponseTime = $TestConnection.ResponseTime
                    Success = $True
                }
            }

            $Error.Clear()
        }

    }
}

$Computers = @('localhost','10.0.10.5','8.8.8.8')

$Results = Test-ConnectionAdvanced $Computers

foreach($item in $Results){
    <#
    if ($item.Success -eq $false){
        $Email = @{
            SMTPServer = 'mail.foo.com'
            From = 'me@foo.com'
            To = 'them@foo.com'
            Subject = 'Failed Ping Test'
            Body = $item
        }
        #Send-MailMessage @Email

    }
    #Export-Csv -InputObject $item -Path C:\Temp\pingtest.csv -Append
    #>

}

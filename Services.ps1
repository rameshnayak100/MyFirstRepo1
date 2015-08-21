
function ChangeStatus($Servicename,$CurrentStatus,$DesiredStatus){

$Serv =  Get-CimInstance -ClassName win32_service -Property StartMode , Name

ForEach($x in $Serv.name){
If($x -eq $Servicename){
        $StatusOfService =  Get-CimInstance -ClassName win32_service -Property StartMode -Filter "Name='$x'"
        $ServStatus = $StatusOfService.Startmode
        If($ServStatus -eq $CurrentStatus){ 
        Set-Service -Name $Servicename -StartupType $DesiredStatus
            }
        }
    }
}

#ChangeStatus $Servicename $CurrentStatus $DesiredStatus 
<# Example of the input 

ChangeStatus   AxInstSV    MANual      AUTO

#>
ChangeStatus	AxInstSV Auto Manual
ChangeStatus	SharedAccess  Manual Disabled
ChangeStatus	AdobeARMservice	Auto	Auto

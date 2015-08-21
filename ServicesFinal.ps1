function Change-ServiceStatus {
  <#
  .SYNOPSIS
  Change the status of the Service
  .DESCRIPTION
  Change the status of the Service from the current status to desired status
  .EXAMPLE
  Change-ServiceStatus -Servicename AxInstSV -CurrentStatus Auto -DesiredStatus manual
  .EXAMPLE
  Change-ServiceStatus -Servicename AxInstSV -CurrentStatus Auto -DesiredStatus manual
  .PARAMETER Servicename
  The Service name to query. Just one.
  .PARAMETER logname
  The name of a file to write failed Service names to. Defaults to errors.txt.
  #>
  [CmdletBinding(SupportsShouldProcess=$True,ConfirmImpact='Low')]
  param
  (
    [Parameter(Mandatory=$True,
    ValueFromPipeline=$True,
    ValueFromPipelineByPropertyName=$True,
      HelpMessage='Which Service would you like to target?')]
    [Alias('host')]
    [ValidateLength(3,30)]
    $Servicename,

    [string[]]$CurrentStatus,

    [string[]]$DesiredStatus,
		
    [string]$logname = 'errors.txt'
  )

  begin {
  write-verbose "Deleting $logname"
    del $logname -ErrorAction SilentlyContinue
  }

  process {

    write-verbose "Beginning process loop"

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
}
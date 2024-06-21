Configuration customBaseServer {
    param(
    [Parameter()]
    [System.String]
    $TimeZone = 'Eastern Standard Time',

    [Parameter()]
    [System.String]
    $Description = $null
    )

    Import-DscResource -ModuleName xTimeZone;

    LocalConfigurationManager {
    DebugMode = "ForceModuleImport"
    }

    if ($Description) {
        Script SetServerDescription {
            SetScript  = {
                Set-WmiInstance -Path "\\localhost\root\cimv2:Win32_OperatingSystem=@" -Arguments @{description = $Description }
            }
            TestScript = {
                $Desc = (Get-WmiObject -computer "localhost" -query "select Description from Win32_OperatingSystem").Value
                return $Desc -eq ""
            }
            GetScript  = {
                return @{
                    Result = (Get-WmiObject -computer "localhost" -query "select Description from Win32_OperatingSystem").Value
                }
            }
        }
    }

    # Set the TimeZone
    xTimeZone SetTimeZone {
    IsSingleInstance = 'Yes'
    TimeZone         = $TimeZone
    }

    Script SwapDVDDrive {
        GetScript  = {
            @{
                GetScript  = $GetScript
                SetScript  = $SetScript
                TestScript = $TestScript
                Result     = $(Get-WmiObject win32_volume -filter "DriveType = '5' AND SystemVolume = null and DriveLetter = 'E:'") -ne $null
            }
        }
        SetScript  = {
            $drv = Get-WmiObject win32_volume -filter "DriveType = '5' AND SystemVolume = null and DriveLetter = 'E:'"

            If ($drv -ne $null) {
                Write-Host "Remapping DVD Drive"
                $drv.DriveLetter = "Z:"
                $drv.Put()
            }
        }
        TestScript = {
            return $(Get-WmiObject win32_volume -filter "DriveType = '5' AND SystemVolume = null and DriveLetter = 'E:'") -eq $null
        }
        DependsOn  = "[xTimeZone]SetTimeZone"
    }

    # Permanently disable ServerManager console from opening up on login
    Registry Disable_ServerManager {
        Key       = 'HKEY_LOCAL_MACHINE\Software\Microsoft\ServerManager\'
        ValueName = 'DoNotOpenServerManagerAtLogon'
        Ensure    = 'Present'
        Force     = $true
        ValueData = '1'
        ValueType = 'Dword'
        DependsOn = '[Script]SwapDVDDrive'
    }
    # Enable SNMP Simple Network Management Protocol
    WindowsFeature Enable_SNMPWMI {
        Name                 = "SNMP-Service"
        Ensure               = "Present"
        IncludeAllSubFeature = $true
        DependsOn            = '[Registry]Disable_ServerManager'
    }
}
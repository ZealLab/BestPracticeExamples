# This is a custom DSC resource that configures the base settings of a server.
# A DSC resource is a PowerShell module that contains a schema file (.psd1) and a script file (.psm1).
# The schema file defines the properties of the resource, and the script file contains the logic for the resource.

# The 'Configuration' block is the main block of a DSC resource.
# It defines the name of the resource.
Configuration customBaseServer {
    # The 'param' block is used to define the parameters of the resource.
    param(
    # The 'TimeZone' parameter specifies the time zone of the server.
    [Parameter()]
    [System.String]
    $TimeZone = 'Eastern Standard Time',

    # The 'Description' parameter specifies the description of the server.
    [Parameter()]
    [System.String]
    $Description = $null
    )

    # The 'Import-DscResource' keyword is used to import the DSC resources that are needed by the resource.
    # In this case, we are importing the 'xTimeZone' module, which contains the 'xTimeZone' resource.
    Import-DscResource -ModuleName xTimeZone;

    # The 'LocalConfigurationManager' resource is used to configure the Local Configuration Manager (LCM) of the node.
    LocalConfigurationManager {
    DebugMode = "ForceModuleImport"
    }

    # This 'if' statement checks if the 'Description' parameter is set.
    if ($Description) {
        # The 'Script' resource is used to run a PowerShell script.
        # This script sets the description of the server.
        Script SetServerDescription {
            # The 'SetScript' block contains the script that is run to apply the configuration.
            SetScript  = {
                Set-WmiInstance -Path "\\localhost\root\cimv2:Win32_OperatingSystem=@" -Arguments @{description = $Description }
            }
            # The 'TestScript' block contains the script that is run to check if the configuration is already applied.
            TestScript = {
                $Desc = (Get-WmiObject -computer "localhost" -query "select Description from Win32_OperatingSystem").Value
                return $Desc -eq ""
            }
            # The 'GetScript' block contains the script that is run to get the current state of the configuration.
            GetScript  = {
                return @{
                    Result = (Get-WmiObject -computer "localhost" -query "select Description from Win32_OperatingSystem").Value
                }
            }
        }
    }

    # This block uses the 'xTimeZone' resource to set the time zone of the server.
    xTimeZone SetTimeZone {
    IsSingleInstance = 'Yes'
    TimeZone         = $TimeZone
    }

    # This script swaps the DVD drive letter to Z:.
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

    # This block uses the 'Registry' resource to disable the Server Manager console from opening on login.
    Registry Disable_ServerManager {
        Key       = 'HKEY_LOCAL_MACHINE\Software\Microsoft\ServerManager\'
        ValueName = 'DoNotOpenServerManagerAtLogon'
        Ensure    = 'Present'
        Force     = $true
        ValueData = '1'
        ValueType = 'Dword'
        DependsOn = '[Script]SwapDVDDrive'
    }
    # This block uses the 'WindowsFeature' resource to enable the SNMP service.
    WindowsFeature Enable_SNMPWMI {
        Name                 = "SNMP-Service"
        Ensure               = "Present"
        IncludeAllSubFeature = $true
        DependsOn            = '[Registry]Disable_ServerManager'
    }
}

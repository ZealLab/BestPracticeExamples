# Name of DSC should be like "Team_ServerPourpose.ServerType"
# Configuration name should match file name
Configuration Example_Application {
    # Module set for base configurations
    Import-DscResource -Module customModules
    # Module for IIS and Web Administration
    Import-DscResource -Module WebAdministrationDsc
    # Module for ACL Directory and File Permissions
    Import-DscResource -ModuleName AccessControlDsc

    # Will compile all nodes in the data file (.psd1)
    Node $AllNodes.NodeName {
        # Base Configurations #####################################################################
        # Joins to domain sets timezone adds security groups ect.
        customBaseServer setup {
            TimeZone = $Node.TimeZone
        }
        customeSecurity Security {
            Domain               = $Node.Domain
            AD_OU                = $Node.AD_OU
            AdditionalAdminUsers = $Node.AdditionalAdminUsers
            RemoteDesktopUsers   = $Node.RemoteDesktopUsers
        }
        customChocoInstalls chocos {
            AdditionalComponents = $AdditionalComponents
        }
        LocalConfigurationManager {
            DebugMode = "All"
        }

        # Roles and Features ######################################################################
        # Command to clone roles and features from a server and set it to the clipboard for use here #
        # (((Get-WindowsFeature | Where {$_.InstallState -eq 'Installed' -and $_.Name -ne "PowerShell-ISE" -and $_.Name -ne "Server-Gui-Mgmt-Infra" -and $_.Name -ne "Server-Gui-Shell" -and $_.Name -ne "" -and $_.Name -ne "SNMP-Service" -and $_.Name -ne "User-Interfaces-Infra" -and $_.Name -ne 'FS-SMB1'}).Name | ForEach-Object {"'$PSItem',"}) -join ' ').TrimEnd(',') | Set-Clipboard
        # These can also be set in the data file
        WindowsFeatureSet IISRolesAndFeatures {
            #Name                 = $Node.Features
            Name                 = @("Web-Server", "Web-Common-Http", "Web-Default-Doc", "Web-Dir-Browsing",
                "Web-Http-Errors", "Web-Static-Content", "Web-Http-Redirect", "Web-Health", "Web-Http-Logging", "Web-ODBC-Logging",
                "Web-Performance", "Web-Stat-Compression", "Web-Dyn-Compression", "Web-Security", "Web-Filtering", "Web-Basic-Auth",
                "Web-App-Dev", "Web-ASP", "Web-ISAPI-Ext", "Web-ISAPI-Filter", "Web-Mgmt-Tools", "Web-Mgmt-Console", "Web-Mgmt-Compat", 
                "Web-Metabase", "Web-Lgcy-Mgmt-Console", "RDC", "RSAT", "RSAT-Feature-Tools", "RSAT-SMTP", "SMTP-Server", "PowerShellRoot", 
                "PowerShell", 'Web-Net-Ext45', 'Web-Asp-Net45', 'NET-Framework-45-Core', 'NET-Framework-45-ASPNET')
            Ensure               = 'Present'
            IncludeAllSubFeature = $false
        }

        # Environment Variables #################################################################
        # Sets windows system environment variables
        Environment envVariable {
            Ensure = 'Present'
            Name   = "envVariable"
            # Variable stored in the data file specific to the node
            Value  = $Node.EnvVariable
        }
        
        # Services ################################################################################
        # Sets service startup type and state
        ServiceSet smtpService {
            Name        = "smtpsvc"
            StartupType = "Automatic"
            State       = "Running"
        }

        # Files and Directories ###################################################################
        # Creates and maintains directory at it's destination
        File webSiteDirectory {
            Ensure          = 'Present'
            DestinationPath = "C:\inetpub\wwwroot\$($Node.SiteDir)"
            Type            = 'Directory'
            # Dependancy is the Feature Set we defined
            DependsOn       = '[WindowsFeatureSet]IISRolesAndFeatures'
        }
        File exportsDirectory {
            Ensure          = 'Present'
            DestinationPath = "C:\inetpub\wwwroot\$($Node.SiteDir)\Exports"
            Type            = 'Directory'
            DependsOn       = '[File]webSiteDirectory'
            # Ability to copy files to directory from a data source
            #SourcePath      = "\\azure.file.core.windows.net\"
            #Recurse         = $true
        }

        # Security and Permissions ################################################################
        # Sets NTFS ACL permissions on the Exports directory
        NtfsAccessEntry exportsPermission {
            Path              = "C:\inetpub\wwwroot\$($Node.SiteDir)\Exports"
            AccessControlList = @(
                # One entry per user
                NTFSAccessControlList {
                    Principal          = "BUILTIN\IIS_IUSRS"
                    ForcePrincipal     = $true
                    AccessControlEntry = @(
                        NTFSAccessControlEntry {
                            AccessControlType = 'Allow'
                            FileSystemRights  = "ReadAndExecute"
                            Inheritance       = 'This folder and files'
                            Ensure            = 'Present'
                        }
                    )
                }
                NTFSAccessControlList {
                    Principal          = "BUILTIN\USERS"
                    ForcePrincipal     = $true
                    AccessControlEntry = @(
                        NTFSAccessControlEntry {
                            AccessControlType = 'Allow'
                            FileSystemRights  = "ReadAndExecute"
                            Inheritance       = 'This folder and files'
                            Ensure            = 'Present'
                        }
                    )
                }
                NTFSAccessControlList {
                    Principal          = "NT SERVICE\TrustedInstaller"
                    ForcePrincipal     = $true
                    AccessControlEntry = @(
                        NTFSAccessControlEntry {
                            AccessControlType = 'Allow'
                            FileSystemRights  = "FullControl"
                            Inheritance       = 'This folder and files'
                            Ensure            = 'Present'
                        }
                    )
                }
            )
            DependsOn         = '[File]exportsDirectory'
        }
    }
}
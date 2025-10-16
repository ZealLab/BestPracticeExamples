# This is the main configuration file for the Example_Application.
# It defines the desired state of the nodes that are part of the application.

# The 'Configuration' block is the main block of a DSC configuration.
# It defines the name of the configuration.
Configuration Example_Application {
    # The 'Import-DscResource' keyword is used to import the DSC resources that are needed by the configuration.
    # In this case, we are importing the 'customModules', 'WebAdministrationDsc', and 'AccessControlDsc' modules.
    Import-DscResource -Module customModules
    Import-DscResource -Module WebAdministrationDsc
    Import-DscResource -ModuleName AccessControlDsc

    # The 'Node' block is used to define the configuration for a specific node.
    # In this case, we are using the '$AllNodes.NodeName' variable to apply the configuration to all nodes defined in the data file.
    Node $AllNodes.NodeName {
        # This block uses the 'customBaseServer' resource to configure the base settings of the server.
        customBaseServer setup {
            TimeZone = $Node.TimeZone
        }
        # This block uses the 'customChocoInstalls' resource to install packages with Chocolatey.
        customChocoInstalls chocos {
            AdditionalComponents = $AdditionalComponents
            Credential = $Node.Credential
        }
        # The 'LocalConfigurationManager' resource is used to configure the Local Configuration Manager (LCM) of the node.
        # The LCM is the engine of DSC. It runs on every target node, and it is responsible for calling the configuration resources that are included in a DSC configuration script.
        LocalConfigurationManager {
            DebugMode = "All"
        }

        # This block uses the 'WindowsFeatureSet' resource to install the IIS roles and features.
        $iisFeatures = @{
            Name                 = $Node.Features
            Ensure               = 'Present'
            IncludeAllSubFeature = $false
        }
        WindowsFeatureSet IISRolesAndFeatures @iisFeatures

        # This block uses the 'Environment' resource to create an environment variable.
        Environment envVariable {
            Ensure = 'Present'
            Name   = "envVariable"
            Value  = $Node.EnvVariable
        }
        
        # This block uses the 'ServiceSet' resource to configure a service.
        ServiceSet smtpService {
            Name        = "smtpsvc"
            StartupType = "Automatic"
            State       = "Running"
        }

        # This block uses the 'File' resource to create a directory.
        File webSiteDirectory {
            Ensure          = 'Present'
            DestinationPath = "C:\inetpub\wwwroot\$($Node.SiteDir)"
            Type            = 'Directory'
            DependsOn       = '[WindowsFeatureSet]IISRolesAndFeatures'
        }
        # This block uses the 'File' resource to create a directory.
        File exportsDirectory {
            Ensure          = 'Present'
            DestinationPath = "C:\inetpub\wwwroot\$($Node.SiteDir)\Exports"
            Type            = 'Directory'
            DependsOn       = '[File]webSiteDirectory'
        }

        # This block uses the 'NtfsAccessEntry' resource to set the NTFS permissions on a directory.
        NtfsAccessEntry exportsPermission {
            Path              = "C:\inetpub\wwwroot\$($Node.SiteDir)\Exports"
            AccessControlList = @(
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
                },
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
                },
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

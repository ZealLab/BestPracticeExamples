# This is the data file for the Example_Application configuration.
# It contains the data that is used by the configuration to configure the nodes.
# Using a data file allows you to separate the configuration data from the configuration logic.
# This makes the configuration more reusable and easier to manage.

@{
    # This is the data for the DEV environment.
    DEV   = @{
        # The 'AllNodes' key contains a list of nodes to be configured.
        AllNodes = @(
            @{
                # The 'NodeName' key specifies the name of the node.
                # In this case, we are using a wildcard '*' to apply the configuration to all nodes.
                NodeName             = "*"
                # The 'Domain' key specifies the domain to which the node should be joined.
                Domain               = "example.com"
                # The 'AD_OU' key specifies the organizational unit in which the node should be created.
                AD_OU                = "OU=Dev"
                # The 'TimeZone' key specifies the time zone of the node.
                TimeZone             = 'Eastern Standard Time'
                # The 'RemoteDesktopUsers' key specifies the users that should be added to the Remote Desktop Users group.
                RemoteDesktopUsers   = @()
                # The 'AdditionalComponents' key specifies additional components to be installed with Chocolatey.
                AdditionalComponents = @()
                # The 'EnvVariable' key specifies the value of an environment variable.
                EnvVariable          = 'EnvValue'
                # The 'SiteDir' key specifies the name of the website directory.
                SiteDir              = 'DevExampleSite'
                # The 'Features' key specifies the Windows features to be installed.
                Features             = @("Web-Server", "Web-Common-Http", "Web-Default-Doc", "Web-Dir-Browsing",
                "Web-Http-Errors", "Web-Static-Content", "Web-Http-Redirect", "Web-Health", "Web-Http-Logging", "Web-ODBC-Logging",
                "Web-Performance", "Web-Stat-Compression", "Web-Dyn-Compression", "Web-Security", "Web-Filtering", "Web-Basic-Auth",
                "Web-App-Dev", "Web-ASP", "Web-ISAPI-Ext", "Web-ISAPI-Filter", "Web-Mgmt-Tools", "Web-Mgmt-Console", "Web-Mgmt-Compat",
                "Web-Metabase", "Web-Lgcy-Mgmt-Console", "RDC", "RSAT", "RSAT-Feature-Tools", "RSAT-SMTP", "SMTP-Server", "PowerShellRoot",
                "PowerShell", 'Web-Net-Ext45', 'Web-Asp-Net45', 'NET-Framework-45-Core', 'NET-Framework-45-ASPNET' )
            },
            @{
                # This block defines the configuration for the 'webserver' node.
                # This configuration will be merged with the configuration for all nodes.
                NodeName             = "webserver"
                # The 'AdditionalAdminUsers' key specifies additional users to be added to the Administrators group.
                AdditionalAdminUsers = @("AD_Security_Group")
            },
            @{
                # This block defines the configuration for the 'sqlserver' node.
                NodeName             = "sqlserver"
                AdditionalAdminUsers = @("AD_Security_Group")
            }
        )
    }
    # This is the data for the STAGE environment.
    STAGE = @{
        AllNodes = @(
            @{
                NodeName             = "*"
                Domain               = "example.com"
                AD_OU                = "OU=Stage"
                TimeZone             = 'Eastern Standard Time'
                RemoteDesktopUsers   = @()
                AdditionalComponents = @()
                SiteDir              = 'StageExampleSite'
                Features             = @("Web-Server", "Web-Common-Http", "Web-Default-Doc", "Web-Dir-Browsing",
                "Web-Http-Errors", "Web-Static-Content", "Web-Http-Redirect", "Web-Health", "Web-Http-Logging", "Web-ODBC-Logging",
                "Web-Performance", "Web-Stat-Compression", "Web-Dyn-Compression", "Web-Security", "Web-Filtering", "Web-Basic-Auth",
                "Web-App-Dev", "Web-ASP", "Web-ISAPI-Ext", "Web-ISAPI-Filter", "Web-Mgmt-Tools", "Web-Mgmt-Console", "Web-Mgmt-Compat",
                "Web-Metabase", "Web-Lgcy-Mgmt-Console", "RDC", "RSAT", "RSAT-Feature-Tools", "RSAT-SMTP", "SMTP-Server", "PowerShellRoot",
                "PowerShell", 'Web-Net-Ext45', 'Web-Asp-Net45', 'NET-Framework-45-Core', 'NET-Framework-45-ASPNET' )
            },
            @{
                NodeName             = "webserver"
                AdditionalAdminUsers = @("AD_Security_Group")
                EnvVariable          = 'EnvValue2'
            },
            @{
                NodeName             = "sqlserver"
                AdditionalAdminUsers = @("AD_Security_Group")
                EnvVariable          = 'EnvValue3'
            }
        )
    }
    # This is the data for the PROD environment.
    PROD  = @{
        AllNodes = @(
            @{
                NodeName             = "*"
                Domain               = "example.com"
                AD_OU                = "OU=Prod"
                TimeZone             = 'Eastern Standard Time'
                RemoteDesktopUsers   = @()
                AdditionalComponents = @()
                EnvVariable          = 'EnvValue4'
                SiteDir              = 'ProdExampleSite'
                Features             = @("Web-Server", "Web-Common-Http", "Web-Default-Doc", "Web-Dir-Browsing",
                "Web-Http-Errors", "Web-Static-Content", "Web-Http-Redirect", "Web-Health", "Web-Http-Logging", "Web-ODBC-Logging",
                "Web-Performance", "Web-Stat-Compression", "Web-Dyn-Compression", "Web-Security", "Web-Filtering", "Web-Basic-Auth",
                "Web-App-Dev", "Web-ASP", "Web-ISAPI-Ext", "Web-ISAPI-Filter", "Web-Mgmt-Tools", "Web-Mgmt-Console", "Web-Mgmt-Compat",
                "Web-Metabase", "Web-Lgcy-Mgmt-Console", "RDC", "RSAT", "RSAT-Feature-Tools", "RSAT-SMTP", "SMTP-Server", "PowerShellRoot",
                "PowerShell", 'Web-Net-Ext45', 'Web-Asp-Net45', 'NET-Framework-45-Core', 'NET-Framework-45-ASPNET' )
            },
            @{
                NodeName             = "webserver"
                AdditionalAdminUsers = @("AD_Security_Group")
            },
            @{
                NodeName             = "sqlserver"
                AdditionalAdminUsers = @("AD_Security_Group")
            }
        )
    }
}
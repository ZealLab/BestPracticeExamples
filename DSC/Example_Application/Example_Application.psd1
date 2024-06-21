# Data file name should match the configuration name in the same directory
@{
    DEV   = @{
        # Settings that apply to the DEV environment
        AllNodes = @(
            @{
                # Settings that apply to all nodes
                NodeName             = "*"
                Domain               = "example.com"
                AD_OU                = "OU=Dev"
                TimeZone             = 'Eastern Standard Time'
                RemoteDesktopUsers   = @()
                AdditionalComponents = @()
                EnvVariable          = 'EnvValue'
                SiteDir              = 'DevExampleSite'
            },
            @{
                # Settings that apply to the webserver node
                NodeName             = "webserver"
                AdditionalAdminUsers = @("AD_Security_Group")
                <#
                Features             = @("Web-Server", "Web-Common-Http", "Web-Default-Doc", "Web-Dir-Browsing",
                "Web-Http-Errors", "Web-Static-Content", "Web-Http-Redirect", "Web-Health", "Web-Http-Logging", "Web-ODBC-Logging",
                "Web-Performance", "Web-Stat-Compression", "Web-Dyn-Compression", "Web-Security", "Web-Filtering", "Web-Basic-Auth",
                "Web-App-Dev", "Web-ASP", "Web-ISAPI-Ext", "Web-ISAPI-Filter", "Web-Mgmt-Tools", "Web-Mgmt-Console", "Web-Mgmt-Compat", 
                "Web-Metabase", "Web-Lgcy-Mgmt-Console", "RDC", "RSAT", "RSAT-Feature-Tools", "RSAT-SMTP", "SMTP-Server", "PowerShellRoot", 
                "PowerShell", 'Web-Net-Ext45', 'Web-Asp-Net45', 'NET-Framework-45-Core', 'NET-Framework-45-ASPNET' )
                #>
            },
            @{
                # Settings tat apply to the sqlserver node
                NodeName             = "sqlserver"
                AdditionalAdminUsers = @("AD_Security_Group")
            }
        )
    }
    STAGE = @{
        # Settings that apply to the STAGE envrionment
        AllNodes = @(
            @{
                # Settings that apply to all nodes
                NodeName             = "*"
                Domain               = "example.com"
                AD_OU                = "OU=Stage"
                TimeZone             = 'Eastern Standard Time'
                RemoteDesktopUsers   = @()
                AdditionalComponents = @()
                SiteDir              = 'StageExampleSite'
            },
            @{
                # Settings that apply to the webserver node
                NodeName             = "webserver"
                AdditionalAdminUsers = @("AD_Security_Group")
                EnvVariable          = 'EnvValue2'
            },
            @{
                # Settings tat apply to the sqlserver node
                NodeName             = "sqlserver"
                AdditionalAdminUsers = @("AD_Security_Group")
                EnvVariable          = 'EnvValue3'
            }
        )
    }
    PROD  = @{
        # Settings that apply to the PROD environment
        AllNodes = @(
            @{
                # Settings that apply to all nodes
                NodeName             = "*"
                Domain               = "example.com"
                AD_OU                = "OU=Prod"
                TimeZone             = 'Eastern Standard Time'
                RemoteDesktopUsers   = @()
                AdditionalComponents = @()
                EnvVariable          = 'EnvValue4'
                SiteDir              = 'ProdExampleSite'
            },
            @{
                # Settings that apply to the webserver node
                NodeName             = "webserver"
                AdditionalAdminUsers = @("AD_Security_Group")
            },
            @{
                # Settings tat apply to the sqlserver node
                NodeName             = "sqlserver"
                AdditionalAdminUsers = @("AD_Security_Group")
            }
        )
    }
}
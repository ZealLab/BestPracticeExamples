# This is a custom DSC resource that installs packages with Chocolatey.
Configuration customChocoInstalls {
    param(
        # The 'AdditionalComponents' parameter specifies additional packages to be installed.
        [Parameter]
        [String]$AdditionalComponents = $Null,
        # The 'Credential' parameter specifies the credentials to use for the installation.
        [Parameter(Mandatory)]
        [System.Management.Automation.PSCredential]$Credential
    )

    # The 'Import-DscResource' keyword is used to import the DSC resources that are needed by the resource.
    Import-DSCResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -Module cChoco

    # This block uses the 'cChocoInstaller' resource to install Chocolatey.
    cChocoInstaller installChoco {
        InstallDir           = "c:\choco"
        # The 'PsDscRunAsCredential' property specifies the credentials to use to run the resource.
        PsDscRunAsCredential = $Credential
    }

    # This block uses the 'cChocoPackageInstallerSet' resource to install a set of base packages.
    cChocoPackageInstallerSet InstallBaseApps {
        Ensure               = 'Present'
        Name                 = @(
            "chocoPackagesToInstall"
        )
        DependsOn            = "[cChocoInstaller]installChoco"
        PsDscRunAsCredential = $Credential
    }

    # This 'if' statement checks if the 'AdditionalComponents' parameter is set.
    if ( $AdditionalComponents -ne $null ) {
        # This block uses the 'cChocoPackageInstallerSet' resource to install additional packages.
        cChocoPackageInstallerSet InstallAdditionalApps {
            Ensure               = 'Present'
            Name                 = $AdditionalComponents
            DependsOn            = "[cChocoPackageInstallerSet]InstallBaseApps"
            PsDscRunAsCredential = $Credential
        }
    }
}
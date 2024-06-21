Configuration customChocoInstalls {
    param(   
        [Parameter]
        [String]$AdditionalComponents = $Null,
        [Parameter]
        [String]$InstallUserAccount = $Null
    )

    Import-DSCResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -Module cChoco

    $DomainJoinCredential = Get-AutomationPsCredential -Name "DomainJoinUser"

    cChocoInstaller installChoco {
        InstallDir           = "c:\choco"
        DependsOn            = "[Script]detectFailedInstall"
        PsDscRunAsCredential = $DomainJoinCredential
    }

    cChocoPackageInstallerSet InstallBaseApps {
        Ensure               = 'Present'
        Name                 = @(
            "chocoPackagesToInstall"
        )
        DependsOn            = "[cChocoInstaller]installChoco"
        PsDscRunAsCredential = $DomainJoinCredential
    }

        if ( $AdditionalComponents -ne $null ) {
        cChocoPackageInstallerSet InstallAdditionalApps {
            Ensure               = 'Present'
            Name                 = $AdditionalComponents
            DependsOn            = "[cChocoPackageInstallerSet]InstallBaseApps"
            PsDscRunAsCredential = $DomainJoinCredential
        }
    }
}
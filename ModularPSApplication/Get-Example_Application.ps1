# Write helpfile with the script / function so it is clear what the intention of the script / function is. This format is compatible with Intelisense and Get-Help commands.
<#
    .NOTES
    --------------------------------------------
    Created by: Ryan Bowen
    Department: Example Department
    Company: Example Company
    Published: 06/03/2024
    Last Modified: 06/03/2024
    --------------------------------------------
    .SYNOPSIS
    This example application represents the best practices in writing a multi modular PowerShell Application
    .DESCRIPTION
    This script can be used as a template to write other applications and as an example for writing clean easy to read code
    .PARAMETER Name
    This should be your name. The script will use this to send a message back to you
    .PARAMETER JobTitle
    This should be your Job Title. The script will use this information to send a message back to you
    .PARAMETER CareerLevel
    This should be what your current career level is
    Entry - Select this to indicate you are at the entry level
    Mid - Select this to indicate you are at a mid level
    Senior - Select this to indicate you are at a senior level
    .INPUTS
    This script ingests data from user
    .OUTPUTS
    This script outputs a friendly message back to the user
    .EXAMPLE
    .\Get-Example_Application -Name "John" -JobTitle "Account Manager"
#>

# Parameters need validations to make error tracking easier, and to make a more secure application.
Param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [String]$Name,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [String]$JobTitle,

    [Parameter(Mandatory)]
    [ValidateSet("Entry","Mid","Senior")]
    [String]$CareerLevel
)
# All modules should be imported at the beginning of the script, not throughout
Import-Module @(".\Modules\moduleA",".\Modules\moduleB.psm1")

# The main script should only contain actions with limmited logic. This makes it much easier for colleagues to understand what the script is doing.

if ((Get-Module moduleA,moduleB).Count -eq 2)
{
    # Always use splat formatting especially when using multiple parameters, this makes it clear and easier to read what is being ingested.
    # Create an object from user interaction
    $params = @{
        Name = $Name
        JobTitle = $JobTitle
        CareerLevel = $CareerLevel
    }
    $userInfo = Set-Example_Information @params

    # Write output to user with data that is ingested
    $params = @{
        UserInfo = $userInfo
    }
    Get-Example_Information @params
}
else {
    Write-Warning "Not all modules loaded correctly"
}
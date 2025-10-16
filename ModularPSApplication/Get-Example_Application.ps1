# This is the main script for the Modular PowerShell Application example.
# It demonstrates how to create a modular application with a main script that calls functions from modules.

# The '#requires' statement specifies the modules that are required by the script.
# If the required modules are not available, the script will not run.
#requires -Modules @{ModuleName = './Modules/moduleA'; ModuleVersion = '1.0'}, @{ModuleName = './Modules/moduleB'; ModuleVersion = '1.0'}

# The '<# ... #>' block is a comment-based help block.
# It provides information about the script, such as its synopsis, description, parameters, and examples.
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

# The 'Param' block is used to define the parameters of the script.
Param(
    # The 'Name' parameter is a mandatory string parameter.
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [String]$Name,

    # The 'JobTitle' parameter is a mandatory string parameter.
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [String]$JobTitle,

    # The 'CareerLevel' parameter is a mandatory string parameter that can only have one of the following values: 'Entry', 'Mid', or 'Senior'.
    [Parameter(Mandatory)]
    [ValidateSet("Entry","Mid","Senior")]
    [String]$CareerLevel
)

# The 'try/catch' block is used to handle errors.
try {
    # The 'Import-Module' cmdlet is used to import the modules that are needed by the script.
    # The '-ErrorAction Stop' parameter tells PowerShell to stop the script if an error occurs while importing the modules.
    Import-Module @("./Modules/moduleA","./Modules/moduleB.psm1") -ErrorAction Stop
}
catch {
    # The 'Write-Warning' cmdlet is used to write a warning message to the console.
    Write-Warning "Not all modules loaded correctly"
    # The 'return' statement is used to exit the script.
    return
}

# This block creates a hashtable with the parameters for the 'Set-Example_Information' function.
# Using a hashtable to pass parameters to a function is a good practice, as it makes the code more readable.
$params = @{
    Name = $Name
    JobTitle = $JobTitle
    CareerLevel = $CareerLevel
}
# This line calls the 'Set-Example_Information' function and passes the parameters to it.
$userInfo = Set-Example_Information @params

# This block creates a hashtable with the parameters for the 'Get-Example_Information' function.
$params = @{
    UserInfo = $userInfo
}
# This line calls the 'Get-Example_Information' function and passes the parameters to it.
Get-Example_Information @params
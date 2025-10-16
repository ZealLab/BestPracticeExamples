# This is a module that contains the 'Get-Example_Information' function.
# A module is a self-contained reusable unit that can contain functions, cmdlets, variables, and more.

# The 'Function' block is used to define a new function.
Function Get-Example_Information {
    # The '<# ... #>' block is a comment-based help block for the function.
    <#
        .Notes
        --------------------------------------------------------
        Created by: Ryan Bowen
        Department: Example Department
        Company: Example Company
        Published: 06/03/2024
        Last Modified: 06/03/2024
        --------------------------------------------------------
        .SYNOPSIS
        This Function is used to write a message based on information given to it as an object
        .DESCRIPTION
        This function will aoutput a message to the user with data ingested
        .PARAMETER UserInfo
        This should be an object that contains the data needed to output the message
        .INPUTS
        This function ingests object from the main script
        .OUTPUTS
        This function writes message to the command line using the data that has been ingested
        .EXAMPLE
        Get-Example_Information
    #>
    # The 'Param' block is used to define the parameters of the function.
    Param(
        # The 'UserInfo' parameter is a mandatory object parameter.
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [PSObject]$UserInfo
    )

    # The 'Write-Host' cmdlet is used to write a message to the console.
    # In this case, we are writing a message to the user with the information that was passed to the function.
    Write-Host -ForegroundColor Green "Hello $($UserInfo.Name) it looks like you are a(n) $($UserInfo.CareerLevel) $($UserInfo.JobTitle). Hope you enjoyed this example. Any feedback let me know, I always want to find ways to improve."
}

# The 'Export-ModuleMember' cmdlet is used to export the functions from the module.
# This makes the functions available to be called from other scripts.
Export-ModuleMember -Function *

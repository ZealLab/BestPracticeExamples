# All Functions should be seperated into modules, not included in the primary script.
Function Get-Example_Information {
    # Functions should have documentation as well. This lets other engineers know what your intentions were for this function.
    # This helps others to understand the thought process throughout the application.
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
    Param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [PSObject]$UserInfo
    )

    # Write output to user
    Write-Host -ForegroundColor Green "Hello $($UserInfo.Name) it looks like you are a(n) $($UserInfo.CareerLevel) $($UserInfo.JobTitle). Hope you enjoyed this example. Any feedback let me know, I always want to find ways to improve."
}

# Export all functions as a module
Export-ModuleMember -Function *
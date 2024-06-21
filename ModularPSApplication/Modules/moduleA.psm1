# All Functions should be seperated into modules, not included in the primary script.
Function Set-Example_Information {
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
        This Function is used to gather the information from the user to be used later on   
        .DESCRIPTION
        This function will accept the users input and output an object with this information
        .PARAMETER Name
        This should be your name. The script will use this to send a message back to the you
        .PARAMETER JobTitle
        This should be your Job Title. The script will use this information to send a message back to you
        .PARAMETER CareerLevel
        This should be what your current career level is
        .INPUTS
        This function ingests data from the main script
        .OUTPUTS
        This function outputs an object back to be used in the main script
        .EXAMPLE
        $obj = Set-Example_Information -Name "John Smith" -JobTitle "Account Manager" -CareerLevel "Senior"
    #>

    # Functions should have validations also for future proofing
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

    return @{
        Name = $Name
        JobTitle = $JobTitle
        $CareerLevel = $CareerLevel
    }
}

# Export all functions as a module
Export-ModuleMember -Function *
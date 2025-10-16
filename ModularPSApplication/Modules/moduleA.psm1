# This is a module that contains the 'Set-Example_Information' function.
# A module is a self-contained reusable unit that can contain functions, cmdlets, variables, and more.

# The 'Function' block is used to define a new function.
Function Set-Example_Information {
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

    # The 'Param' block is used to define the parameters of the function.
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

    # The 'return' statement is used to return a value from the function.
    # In this case, we are returning a custom object with the user's information.
    return [PSCustomObject]@{
        Name = $Name
        JobTitle = $JobTitle
        CareerLevel = $CareerLevel
    }
}

# The 'Export-ModuleMember' cmdlet is used to export the functions from the module.
# This makes the functions available to be called from other scripts.
Export-ModuleMember -Function *
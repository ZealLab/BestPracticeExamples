Configuration customSecurity {

    param
    (   
    [Parameter]
    [String]$Domain = 'example.com',

    [Parameter]
    [String]$AD_OU = $null,
    
    [Parameter]
    [String]$AdditionalAdminUsers = @(),

    [Parameter][String]
    $RemoteDesktopUsers = @()
    )

    ### Custom security configuration goes here. Security by obscurity ;) ###
    # This configuration should do the following:
    # Join machine to the domain
    # Add admin groups / accounts to machine
    # Configure RDP
    # Set acceptable encryption protocols / cyphers
    # Configure PS Remoting
    # Configure registry values and various protocols
    # And more

}
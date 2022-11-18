# Import variables
$CurrentDirectory = Get-Location
. $CurrentDirectory\_variables.ps1

# Printing details on the currently selected Subscription
Write-Output "Subscription ID: $((Get-AzContext).Subscription.Id)"
Write-Output "Subscription Name: $((Get-AzContext).Subscription.Name)"


# ---------------Create virtual network--------
$vnet = @{
    Name = $VnetOdusName
    ResourceGroupName = $RgOdusName
    Location = $Location
    AddressPrefix = $VnetOdusIpPrefix    
}

$virtualNetwork = New-AzVirtualNetwork @vnet

# ---------------Create subnets----------------

# Create default subnet
$subnet_default = @{
    Name = $SubnetOdusDefaultName
    VirtualNetwork = $virtualNetwork
    AddressPrefix = $SubnetOdusDefaultPrefix
}

Add-AzVirtualNetworkSubnetConfig @subnet_default

# Link all subnets to the virtual network
$virtualNetwork | Set-AzVirtualNetwork

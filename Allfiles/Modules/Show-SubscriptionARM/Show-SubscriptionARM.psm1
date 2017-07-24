Function Show-SubscriptionARM
# Select the target subscription (Resource Manager)

{

    $subs = Get-AzureRmSubscription

    #Check the number of subscriptions associated with the current account 

    if($subs.Count -eq 0)
    {
        Write-Host "No subscriptions found. Sign in with an account that is associated with an Azure subscription"
        Return
    }
    elseif($subscriptionId)
    {
        Write-Host "Subscription already selected - using the subscription: " $subscriptionId " (Resource Manager)"
        Set-AzureRmContext -SubscriptionId $subscriptionId
    }
    elseif($subs.Count -gt 1)
    {
        while($true)
        {
            for($i = 1;$i -lt ($subs.Count + 1); $i++)
            {
                Write-Host "[$i] - " $subs[$i-1].Name "- Id: " $subs[$i-1].Id
            }

            Write-Host 
            $selectedSub = Read-Host -Prompt "Select the Azure subscription" 
            Write-Host 
            [int] $selectedEntry = $null
            if([int32]::TryParse($selectedSub, [ref]$selectedEntry) -eq $true)
            {
                if($selectedEntry -ge 1 -and $selectedEntry -lt ($subs.Count + 1))
                {
                    Write-Host "Using subscription: " $subs[$selectedEntry - 1].Name " Id: " $subs[$selectedEntry - 1].Id " (Resource Manager)"
                    Set-AzureRmContext -SubscriptionId $subs[$selectedEntry - 1].Id
		    $global:subscriptionId = $subs[$selectedEntry - 1].Id
                    break               
                }
            }
        }
    }
    else 
    {
        Write-Host "Using the subscription: " $subs[0].Name " Id: " $subs[0].Id " (Resource Manager)"
        Set-AzureRmContext -SubscriptionId $subs[0].Id
    }

}

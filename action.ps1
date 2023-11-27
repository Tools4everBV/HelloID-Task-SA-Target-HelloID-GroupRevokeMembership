# HelloID-Task-SA-Target-HelloID-GroupRevokeMembership
###########################################################
# Form mapping
$formObject = @{
    groupToRemoveGUID = $form.groupToRemoveGUID
    groupToRemoveName = $form.groupToRemoveName
    groupGUID      = $form.groupGUID
    groupName      = $form.groupName
}

try {
    Write-Information "Executing HelloID action: [RevokeMembership] to Group: [$($formObject.groupName)] for Group: [$($formObject.groupToRemoveName)]"
    Write-Verbose "Creating authorization headers"
    # Create authorization headers with HelloID API key
    $pair = "${portalApiKey}:${portalApiSecret}"
    $bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
    $base64 = [System.Convert]::ToBase64String($bytes)
    $key = "Basic $base64"
    $headers = @{"authorization" = $Key }

    Write-Verbose "Revoking Membership to HelloIDGroup: [$($formObject.groupName)] for HelloIDGroup: [$($formObject.groupToRemoveName)]"
    $splatRemoveGroupParams = @{
        Uri         = "$($portalBaseUrl)/api/v1/groups/$($formObject.groupGUID)/membergroups/$($formObject.groupToRemoveGUID)"
        Method      = "DELETE"
        Verbose     = $false
        Headers     = $headers
        ContentType = "application/json"
    }
    $response = Invoke-RestMethod @splatRemoveGroupParams

    $auditLog = @{
        Action            = "RevokeMembership"
        System            = "HelloID"
        TargetIdentifier  = [String]$formObject.groupToRemoveGUID
        TargetDisplayName = [String]$formObject.groupToRemoveName
        Message           = "HelloID action: [RevokeMembership] to Group: [$($formObject.groupName)] for Group: [$($formObject.groupToRemoveName)] executed successfully"
        IsError           = $false
    }
    Write-Information -Tags "Audit" -MessageData $auditLog

    Write-Information "HelloID action: [RevokeMembership] to Group: [$($formObject.groupName)] for Group: [$($formObject.groupToRemoveName)] executed successfully"
}
catch {
    $ex = $_
    $auditLog = @{
        Action            = "RevokeMembership"
        System            = "HelloID"
        TargetIdentifier  = [String]$formObject.groupToRemoveGUID
        TargetDisplayName = [String]$formObject.groupToRemoveName
        Message           = "Could not execute HelloID action: [RevokeMembership] to Group: [$($formObject.groupName)] for Group: [$($formObject.groupToRemoveName)], error: $($ex.Exception.Message)"
        IsError           = $true
    }
    if ($($ex.Exception.GetType().FullName -eq "Microsoft.PowerShell.Commands.HttpResponseException")) {
        $auditLog.Message = "Could not execute HelloID action: [RevokeMembership] to Group: [$($formObject.groupName)] for Group: [$($formObject.groupToRemoveName)]"
        Write-Error "Could not execute HelloID action: [RevokeMembership] to Group: [$($formObject.groupName)] for Group: [$($formObject.groupToRemoveName)], error: $($ex.ErrorDetails)"
    }
    Write-Information -Tags "Audit" -MessageData $auditLog
    Write-Error "Could not execute HelloID action: [RevokeMembership] to Group: [$($formObject.groupName)] for Group: [$($formObject.groupToRemoveName)], error: $($ex.Exception.Message)"
}
###########################################################
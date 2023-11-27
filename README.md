# HelloID-Task-SA-Target-HelloID-GroupRevokeMembership

<a href="https://github.com/Tools4everBV/HelloID-Task-SA-Target-HelloID-GroupRevokeMembership/network/members"><img src="https://img.shields.io/github/forks/Tools4everBV/HelloID-Task-SA-Target-HelloID-GroupRevokeMembership" alt="Forks Badge"/></a>
<a href="https://github.com/Tools4everBV/HelloID-Task-SA-Target-HelloID-GroupRevokeMembership/pulls"><img src="https://img.shields.io/github/issues-pr/Tools4everBV/HelloID-Task-SA-Target-HelloID-GroupRevokeMembership" alt="Pull Requests Badge"/></a>
<a href="https://github.com/Tools4everBV/HelloID-Task-SA-Target-HelloID-GroupRevokeMembership/issues"><img src="https://img.shields.io/github/issues/Tools4everBV/HelloID-Task-SA-Target-HelloID-GroupRevokeMembership" alt="Issues Badge"/></a>
<a href="https://github.com/Tools4everBV/HelloID-Task-SA-Target-HelloID-GroupRevokeMembership/graphs/contributors"><img alt="GitHub contributors" src="https://img.shields.io/github/contributors/Tools4everBV/HelloID-Task-SA-Target-HelloID-GroupRevokeMembership?color=2b9348"></a>

## Prerequisites
- [ ] HelloID API key and secret
- [ ] Pre-defined variables: `portalBaseUrl`, `portalApiKey` and `portalApiSecret` created in your HelloID portal.

## Description
This code snippet will remove an existing group from an existing group within HelloID and executes the following tasks:

1. Define a hash table `$formObject`. The keys of the hash table represent the properties necessary to remove an existing group from an existing group within `HelloID`, while the values represent the values entered in the form.

> To view an example of the form output, please refer to the JSON code pasted below.

```json
{
    "groupToRemoveGUID": "9f2c94e5a-7881-455a-a727-3fafd9d926e0",
    "groupToRemoveName": "John Doe's group To Remove",
    "groupGUID": "9509133d-8ae4-48bf-a2cb-e0f31cae4deb",
    "groupName": "John Doe's group"
}
```

> :exclamation: It is important to note that the names of your form fields might differ. Ensure that the `$formObject` hash table is appropriately adjusted to match your form fields.
> [See the HelloID API Docs page](https://apidocs.helloid.com/docs/helloid/86733b4ccbb77-unlink-a-group-from-a-group-1)

2. Creates authorization headers using the provided API key and secret.

3. remove an existing group from an existing group using the: `Invoke-RestMethod` cmdlet. The hash table called: `$formObject` is passed to the body of the: `Invoke-RestMethod` cmdlet as a JSON object.

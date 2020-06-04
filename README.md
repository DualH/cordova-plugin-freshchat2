# cordova-plugin-freshchat2

This plugin integrates Freshchat's SDK into a Ionic/Cordova project.

# Supported platforms
 - Android
 - iOS

**IMPORTANT:** Before opening an issue against this plugin, please read [Reporting issues](#reporting-issues).

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [Installation](#installation)
  - [Supported Cordova Versions](#supported-cordova-versions)
  - [Supported Mobile Platform Versions](#supported-mobile-platform-versions)
    - [Ionic 4+](#ionic-4)
    - [Ionic 3](#ionic-3)
- [Example project](#example-project)
- [Reporting issues](#reporting-issues)
  - [Reporting a bug or problem](#reporting-a-bug-or-problem)
  - [Requesting a new feature](#requesting-a-new-feature)
- [API](#api)
  - [init](#init)
  - [updateUser](#updateuser)
  - [updateUserProperties](#updateuserproperties)
  - [logUserEvent](#loguserevent)
  - [resetUserData](#resetuserdata)
  - [getRestoreId](#getrestoreid)
  - [setExternalId](#setexternalid)
  - [restoreUser](#restoreuser)
  - [showConversations](#showconversations)
  - [unreadCount](#unreadcount)
  - [showFAQs](#showfaqs)
  - [sendMessage](#sendmessage)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Installation
Install the plugin by adding it to your project's config.xml:
```xml
<plugin name="cordova-plugin-freshchat2" spec="latest" />
```
or by running:
```
$ cordova plugin add cordova-plugin-freshchat2
```

## Supported Cordova Versions
- cordova: `>= 9`
- cordova-android: `>= 8`
- cordova-ios: `>= 5`

## Supported Mobile Platform Versions
- Android `>= 4.1`
- iOS `>= 8.0`

### Ionic 4+
First install the package.

```
ionic cordova plugin add cordova-plugin-freshchat2
npm install freshchat2
```
    
If you're using Angular, register it in your component/service's `NgModule` (for example, app.module.ts) as a provider.

```typescript
import { Freshchat2 } from "freshchat2/ngx";

@NgModule({
    //declarations, imports...
    providers: [
        Freshchat2,
        //other providers...
    ]
})
```

Then you're good to go.
```typescript
import { Freshchat2 } from "freshchat2/ngx";

//...

constructor(private freshchat2: Freshchat2)

this.freshchat2.init(props)
.then(() => {
  console.log('Init called successfully');
})
.catch(() => {
  console.error('Something are wrong');
});
```
  
### Ionic 3
(i.e. `import { Freshchat2 } from "freshchat2"` will not work).

To use `cordova-plugin-freshchat2` with Ionic 3, you'll need to call its Javascript API directly from your Typescript app code, for example:

```typescript
(<any> window).Freshchat2.init(() => {
  console.log('Init called successfully');
},
() => {
  console.error('Something are wrong');
});
```

# Example project
An example project repo exists to demonstrate and validate the functionality of this plugin:
https://github.com/DualH/cordova-plugin-freshchat2-test

Please use this as a working reference.

Before reporting any issues, please (if possible) test against the example project to rule out causes external to this plugin.

# Reporting issues
**IMPORTANT:** Please read the following carefully. 
Failure to follow the issue template guidelines below will result in the issue being immediately closed.

## Reporting a bug or problem
Before [opening a bug issue](https://github.com/DualH/cordova-plugin-freshchat2/issues/new?assignees=&labels=&template=bug_report.md&title=), please do the following:
- *DO NOT* open issues asking for support in using/integrating the plugin into your project
    - Only open issues for suspected bugs/issues with the plugin that are generic and will affect other users
    - I don't have time to offer free technical support: this is free open-source software
    - Ask for help on StackOverflow, Ionic Forums, etc.
    - Use the [example project](https://github.com/DualH/cordova-plugin-freshchat2-test) as a known working reference
    - Any issues requesting support will be closed immediately.
- Check the [CHANGELOG](https://github.com/DualH/cordova-plugin-freshchat2/blob/master/CHANGELOG.md) for any breaking changes that may be causing your issue.
- Check a similar issue (open or closed) does not already exist against this plugin.
	- Duplicates or near-duplicates will be closed immediately.
- When [creating a new issue](https://github.com/DualH/cordova-plugin-freshchat2/issues/new/choose)
    - Choose the "Bug report" template
    - Fill out the relevant sections of the template and delete irrelevant sections
    - *WARNING:* Failure to complete the issue template will result in the issue being closed immediately. 
- Reproduce the issue using the [example project](https://github.com/DualH/cordova-plugin-freshchat2-test)
	- This will eliminate bugs in your code or conflicts with other code as possible causes of the issue
	- This will also validate your development environment using a known working codebase
	- If reproducing the issue using the example project is not possible, create an isolated test project that you are able to share
- Include full verbose console output when reporting build issues
    - If the full console output is too large to insert directly into the Github issue, then post it on an external site such as [Pastebin](https://pastebin.com/) and link to it from the issue 
    - Often the details of an error causing a build failure is hidden away when building with the CLI
        - To get the full detailed console output, append the `--verbose` flag to CLI build commands
        - e.g. `cordova build ios --verbose`
    - Failure to include the full console output will result in the issue being closed immediately
- If the issue relates to the plugin documentation (and not the code), please of a [documentation issue](https://github.com/DualH/cordova-plugin-freshchat2/issues/new?assignees=&labels=&template=documentation-issue.md&title=)

## Requesting a new feature
Before [opening a feature request issue](https://github.com/DualH/cordova-plugin-freshchat2/issues/new?assignees=&labels=&template=feature_request.md&title=), please do the following:
- Check the above documentation to ensure the feature you are requesting doesn't already exist
- Check the list if open/closed issues to check if there's a reason that feature hasn't been included already
- Ensure the feature you are requesting is actually possible to implement and generically useful to other users than yourself
- Where possible, post a link to the documentation related to the feature you are requesting
- Include other relevant links, e.g.
  - Stack Overflow post illustrating a solution
  - Code within another Github repo that illustrates a solution 

# API
The list of available methods for this plugin is described below.

## init
Invoke Freshchat.init() with your app id and app key before invoking/ attempting to use any other features of Freshchat SDK.  

We highly recommend invoking init() from your app's launcher/support activity's onCreate() function. Freshchat SDK checks for presence of its components during init() and will warn about missing components when it detects the components are missing or their manifest entries are missing. 

Replace the `<YOUR-APP-ID>` and `<YOUR-APP-KEY>` in the following code snippet with the actual app ID and app key.

**Parameters**:
- {object} config - Object with properties to init the sdk
- {function} success - callback function which will be passed the {string} message as an argument
- {function} error - callback function which will be passed a {string} error message as an argument

```typescript
// config
{
  appId: string;
  appKey: string;
  gallerySelectionEnabled?: boolean;
  cameraCaptureEnabled?: boolean;
  teamMemberInfoVisible?: boolean;
  showNotificationBanner?: boolean;
  responseExpectationVisible?: boolean;
  domain?: string;
}
```

```javascript
Freshchat2.init(config, function() {
  console.log('init called successfully');
}, function() {
  console.error('Something are wrong');
});
```

## updateUser
You can send basic user information at any point to give you more context on the user when your support agents are messaging back and forth with them. 

**Parameters**:
- {object} user - Object with data of our user
- {function} success - callback function which will be passed the {string} message as an argument
- {function} error - callback function which will be passed a {string} error message as an argument

```typescript
// user
{
  firstName?: string;
  lastName?: string;
  email?: string;
  phoneCountryCode?: string;
  phoneNumber?: string;
}
```

```javascript
Freshchat2.updateUser(user, function() {
  console.log('updateUser called successfully');
}, function() {
  console.error('Something are wrong');
});
```

## updateUserProperties
## logUserEvent
## resetUserData
## getRestoreId
## setExternalId
## restoreUser
## showConversations
## unreadCount
## showFAQs
## sendMessage

<!-- # New things!

  - Reimplementation of all of their methods
  - It's going to be mantained by me and any contributor that wishes to collaborate


You can also:
  - Open conversations with an agent, with or without params to filter this
  - Open your FAQs with or without params to filter this
  - Send hidden messages to generate enviroment information before out client opens up a conversation
  - Know the amount of unread messages in the chat

### Installation


For now you can install the plugin directly from this repo

```sh
$ cordova plugin add https://github.com/DualH/cordova-plugin-freshchat
```

### Todos
 - Integrate native code for Android
 - Create a new native code for Swift
 - Register the plugin in npm
 - Try to create a native wrapper for IonicNative

License
----

MIT -->

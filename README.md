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
- [Todos](#todos)
- [Copyright ©](#copyright-%C2%A9)

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
- {object} config - object with properties to init the sdk
- {function} success - callback function which will be passed the {string} message as an argument
- {function} error - callback function which will be passed a {string} error message as an argument

```typescript
// config: FreshchatConfig
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
- {object} user - object with data of our user
- {function} success - callback function which will be passed the {string} message as an argument
- {function} error - callback function which will be passed a {string} error message as an argument

```typescript
// user: FreshchatUser
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
You can capture and send additional metadata about the user and the events in the app, all of which also becomes a way to segment your users to later push messages to them.

**Parameters**:
- {object} properties - object with custom properties replace `key1, key2, ...` for you data
- {function} success - callback function which will be passed the {string} message as an argument
- {function} error - callback function which will be passed a {string} error message as an argument

```typescript
// properties
{
  key1: string|number|boolean,
  key2: string|number|boolean,
  ...
}
```

```javascript
Freshchat2.updateUserProperties(properties, function() {
  console.log('updateUserProperties called successfully');
}, function() {
  console.error('Something are wrong');
});
```

## logUserEvent
Tracking user events provides more insight and context about the user(s) in your application. Events like user actions, failure/error cases can be tracked using this API. Tracked events are listed under Events Timeline on the agent side.

**NOTE:**
- Freshchat allows only 121 unique events per account
- Event name accepts string value (max 32 chars)
- Property key name should be of string type (max 32 chars)
- Property value can be of any primitive object type (max 256 chars)
- Freshchat allows sending a maximum of 20 properties per event

**Parameters**:
- {string} name - name of track event
- {any} values - data of track event
- {function} success - callback function which will be passed the {string} message as an argument
- {function} error - callback function which will be passed a {string} error message as an argument

```javascript
Freshchat2.logUserEvent(name, values, function() {
  console.log('logUserEvent called successfully');
}, function() {
  console.error('Something are wrong');
});
```

## resetUserData
Reset user data at logout or when deemed appropriate based on user action in the app by invoking this API.

**Parameters**:
- {function} success - callback function which will be passed the {string} message as an argument
- {function} error - callback function which will be passed a {string} error message as an argument

```javascript
Freshchat2.resetUserData(function() {
  console.log('resetUserData called successfully');
}, function() {
  console.error('Something are wrong');
});
```

## getRestoreId
This is generated by Freshchat for the current user, given an external id was set and can be retrieved anytime using this API. The app is responsible for storing and later present the combination of external id and restore id to the Freshchat SDK to continue the chat conversations across sessions on same device or across devices and platforms.

**Parameters**:
- {function} success - callback function which will be passed the {string} restoreId as an argument
- {function} error - callback function which will be passed a {string} error message as an argument

```javascript
Freshchat2.getRestoreId(function(restoreId) {
  console.log('RestoreId: ' + restoreId);
}, function() {
  console.error('Something are wrong');
});
```

## setExternalId
This should (ideally) be a unique identifier for the user from your system like a user id or email id and is set using this API. This cannot be changed once set for the user.

**Parameters**:
- {string} externalId - our custom identifier for user
- {function} success - callback function which will be passed the {string} message as an argument
- {function} error - callback function which will be passed a {string} error message as an argument

```javascript
Freshchat2.setExternalId(externalId, function() {
  console.log('setExternalId called successfully');
}, function() {
  console.error('Something are wrong');
});
```

## restoreUser
For retaining the chat messages across devices/sessions/platforms, the mobile app needs to pass the same external id and restore id combination for the user. This will allow users to seamlessly pick up the conversation from any of the supported platforms - Android, iOS, and Web.

**Parameters**:
- {string} externalId - our custom identifier for user setted in [setExternalId()](#setexternalid) API
- {string} restoreId - the restoreId returned by [getRestoreId()](#getrestoreid) API
- {function} success - callback function which will be passed the {string} message as an argument
- {function} error - callback function which will be passed a {string} error message as an argument

```javascript
Freshchat2.restoreUser(externalId, restoreId, function() {
  console.log('restoreUser called  successfully');
}, function() {
  console.error('Something are wrong');
});
```

## showConversations
In response to specific UI events like a menu selection or button on click event, invoke the showConversations() API to launch the Conversation Flow. If the app has multiple channels configured, the user will see the channel list. Channel list is ordered as specified in the Dashboard (link to channel list in dashboard) when there are no messages. When messages are present, the order is based on most recently interacted channel. 

**NOTE:**
- Only Message Channels with visibility set to "Visible to all users" will be displayed when using showConversations() API

**Parameters**:
- {object} options - options to init conversations
- {function} success - callback function which will be passed the {string} message as an argument
- {function} error - callback function which will be passed a {string} error message as an argument

```typescript
// options: FreshchatConversationsOptions
{
  tags?: string[];
  filteredViewTitle?: string
}
```

```javascript
Freshchat2.showConversations(options, function() {
  console.log('showConversations called successfully');
}, function() {
  console.error('Something are wrong');
});
```

## unreadCount
If you would like to obtain the number of unread messages for the user at app launch or any other specific event, use this API and display the count.

**Parameters**:
- {function} success - callback function which will be passed the {number} number of message as an argument
- {function} error - callback function which will be passed a {string} error message as an argument

```javascript
Freshchat2.unreadCount(function(count) {
  console.log('unreadCount: ' + count);
}, function() {
  console.error('Something are wrong');
});
```

## showFAQs
In response to specific UI events like a menu selection or button click event, invoke this API to launch the FAQ screen. By default the FAQ Categories is displayed as a grid with a “Contact Us” button at the bottom. For customising this, check the FAQ Options.

**Parameters**:
- {object} options - options to init FAQs
- {function} success - callback function which will be passed the {string} message as an argument
- {function} error - callback function which will be passed a {string} error message as an argument

```typescript
// options: FreshchatFAQsOptions
{
  tags?: string[];
  articleType?: string;
  filteredViewTitle?: string;
  contactusTags?: string[];
  contactusFilterTitle?: string;
}
```

```javascript
Freshchat2.showFAQs(options, function() {
  console.log('showFAQs called successfully');
}, function() {
  console.error('Something are wrong');
});
```

## sendMessage
The app can send a message on behalf of the user using the sendMessage() API. 

**NOTE:**
- This API would silently send a message and not launch the Freshchat SDK UI

**Parameters**:
- {string} message - message to send
- {string} tag - tag to filter in a future
- {function} success - callback function which will be passed the {string} message as an argument
- {function} error - callback function which will be passed a {string} error message as an argument

```javascript
Freshchat2.sendMessage(message, tag, function() {
  console.log('sendMessage called successfully');
}, function() {
  console.error('Something are wrong');
});
```

# Todos
  - Integrate native code for Android
  - Compability with Capacitor
  - Register the plugin in npm
  - Create a native wrapper for Typescript
  - Create a demo app

# Copyright ©
- [Freshworks Inc. All Rights Reserved](https://www.freshworks.com/live-chat-software/).

/********* Freshchat2.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "FreshchatSDK/FreshchatSDK.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

NSString *const PLUGIN_NAME = @"Freshchat2";

@interface Freshchat2 : CDVPlugin 

- (void) init: (CDVInvokedUrlCommand*) command;
- (void) updateUser: (CDVInvokedUrlCommand*) command;
- (void) updateUserProperties: (CDVInvokedUrlCommand*) command;
- (void) logUserEvent: (CDVInvokedUrlCommand*) command;
- (void) resetUserData: (CDVInvokedUrlCommand*) command;
- (void) getRestoreId: (CDVInvokedUrlCommand*) command;
- (void) setExternalId: (CDVInvokedUrlCommand*) command;
- (void) restoreUser: (CDVInvokedUrlCommand*) command;
- (void) showConversations: (CDVInvokedUrlCommand*) command;
- (void) unreadCount: (CDVInvokedUrlCommand*) command;
- (void) showFAQs: (CDVInvokedUrlCommand*) command;
- (void) sendMessage: (CDVInvokedUrlCommand*) command;

@end

@implementation Freshchat2 : CDVPlugin

// Helpers
- (void) sendResponseErrorJavascript: (NSString*) text ForCommand: (CDVInvokedUrlCommand*) command {
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:text];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    return;
}

- (void) sendResponseSuccessJavascript:(NSString*) text ForCommand: (CDVInvokedUrlCommand*) command {
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:text];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    return;
}

// Plugin Freshchat2
- (void) init:(CDVInvokedUrlCommand*) command {
    NSArray* arguments = [command arguments];

    // Return a error when missed parameters
    if (arguments == nil || arguments.count < 1) {
        [self sendResponseErrorJavascript:@"Some arguments missed, verify please" ForCommand:command];
        return;
    }

    NSDictionary* initParams = [arguments firstObject];

    NSString* domain = [initParams objectForKey:@"domain"];
    NSString* appId  = [initParams objectForKey:@"appId"];
    NSString* appKey = [initParams objectForKey:@"appKey"];

    if (appId == nil) {
        [self sendResponseErrorJavascript:@"appId is missed" ForCommand:command];
        return;
    }

    if (appKey == nil) {
        [self sendResponseErrorJavascript:@"appKey is missed" ForCommand:command];
        return;
    }
    
    // Initialize Freshchat
    FreshchatConfig *config = [[FreshchatConfig alloc]initWithAppID:appId andAppKey:appKey];
    [[Freshchat sharedInstance] initWithConfig:config];

    NSLog(@"[%@]: Initialized plugin with, appId: %@, appKey:%@", PLUGIN_NAME, appId, appKey);
    
    if (domain) {
        config.domain = domain;
    }
    
    if (initParams[@"gallerySelectionEnabled"]) {
        config.gallerySelectionEnabled = [[initParams objectForKey:@"gallerySelectionEnabled"] boolValue];
    }

    if (initParams[@"cameraCaptureEnabled"]) {
        config.cameraCaptureEnabled = [[initParams objectForKey:@"cameraCaptureEnabled"] boolValue];
    }

    if (initParams[@"teamMemberInfoVisible"]) {
        config.teamMemberInfoVisible = [[initParams objectForKey:@"teamMemberInfoVisible"] boolValue];
    }

    if (initParams[@"showNotificationBanner"]) {
        config.showNotificationBanner = [[initParams objectForKey:@"showNotificationBanner"] boolValue];
    }

    if (initParams[@"responseExpectationVisible"]) {
        config.responseExpectationVisible = [[initParams objectForKey:@"responseExpectationVisible"] boolValue];
    }
    
    [[Freshchat sharedInstance] initWithConfig:config];

    // Return when app is initializes
    [self sendResponseSuccessJavascript:@"Plugin initialized" ForCommand:command];
    return;
}

- (void) updateUser:(CDVInvokedUrlCommand*) command {
    NSArray* arguments = [command arguments];

    // Return a error when missed parameters
    if (arguments == nil || arguments.count < 1) {
        [self sendResponseErrorJavascript:@"Some arguments missed, verify please" ForCommand:command];
        return;
    }

    NSDictionary* properties = [arguments firstObject];

    // Create a user object
    FreshchatUser *user = [FreshchatUser sharedInstance];

    // To set an identifiable first name for the user
    if (properties[@"firstName"]) {
        user.firstName = [properties objectForKey:@"firstName"];
    }

    // To set an identifiable last name for the user
    if (properties[@"lastName"]) {
        user.lastName = [properties objectForKey:@"lastName"];
    }

    // To set user's email id
    if (properties[@"email"]) {
        user.email = [properties objectForKey:@"email"];
    }

    // To set user's phone number
    if (properties[@"phoneCountryCode"]) {
        user.phoneCountryCode = [properties objectForKey:@"phoneCountryCode"];
    }

    if (properties[@"phoneNumber"]) {
        user.phoneNumber = [properties objectForKey:@"phoneNumber"];
    }

    [[Freshchat sharedInstance] setUser:user];

    // Return when user is updated
    [self sendResponseSuccessJavascript:@"User updated" ForCommand:command];
    return;
}

- (void) updateUserProperties:(CDVInvokedUrlCommand*) command {
    NSArray* arguments = [command arguments];

    // Return a error when missed parameters
    if (arguments == nil || arguments.count < 1) {
        [self sendResponseErrorJavascript:@"Some arguments missed, verify please" ForCommand:command];
        return;
    }

    NSDictionary* properties = [arguments firstObject];

    NSArray* arrKeys = [properties allKeys];
    NSArray* arrValues = [properties allValues];

    for (int i = 0; i < arrKeys.count; i++) {
        NSString* key = [arrKeys objectAtIndex:i];
        NSString* val = [arrValues objectAtIndex:i];

        NSLog(@"[%@]: Applying user property: %@:%@", PLUGIN_NAME, key, val);

        [[Freshchat sharedInstance] setUserPropertyforKey:key withValue:val];
    }

    [self sendResponseSuccessJavascript:@"All properties updated" ForCommand:command];
    return;
}

/*
1. Freshchat allows only 121 unique events per account.
2. Event name accepts string value (max 32 chars). 
3. Property key name should be of string type (max 32 chars). 
4. Property value can be of any primitive object type (max 256 chars). 
5. Freshchat allows sending a maximum of 20 properties per event.
*/
- (void) logUserEvent:(CDVInvokedUrlCommand*) command {
    NSArray* arguments = [command arguments];

    // Return a error when missed parameters
    if (arguments == nil || arguments.count < 2) {
        [self sendResponseErrorJavascript:@"Some arguments missed, verify please" ForCommand:command];
        return;
    }

    NSString* eventName = [arguments objectAtIndex:0];
    if (eventName == nil) {
        [self sendResponseErrorJavascript:@"For LogUserEvent must be include the eventName" ForCommand:command];
        return;
    }

    NSDictionary* eventValues = [arguments objectAtIndex:1];
    if (eventValues == nil) {
        [self sendResponseErrorJavascript:@"For LogUserEvent must be include the eventValue(s)" ForCommand:command];
        return;
    }

    NSLog(@"[%@]: Try log event %@:%@", PLUGIN_NAME, eventName, eventValues);

    [[Freshchat sharedInstance] trackEvent:eventName withProperties:eventValues];
    [self sendResponseSuccessJavascript:@"Event logged" ForCommand:command];
    return;
}

- (void) resetUserData:(CDVInvokedUrlCommand*) command {
    [[Freshchat sharedInstance] resetUserWithCompletion:^{
        [self sendResponseSuccessJavascript:@"User data reseted" ForCommand:command];
        return;
    }];
}

- (void) getRestoreId:(CDVInvokedUrlCommand*) command {
    NSString *restoreId = [FreshchatUser sharedInstance].restoreID;

    NSLog(@"[%@]: restoreId %@", PLUGIN_NAME, restoreId);

    [self sendResponseSuccessJavascript:restoreId ForCommand:command];
    return;
}

- (void) setExternalId:(CDVInvokedUrlCommand*) command {
    NSArray* arguments = [command arguments];

    // Return a error when missed parameters
    if (arguments == nil || arguments.count < 1) {
        [self sendResponseErrorJavascript:@"Some arguments missed, verify please" ForCommand:command];
        return;
    }

    NSString* externalId = [arguments firstObject];

    [[Freshchat sharedInstance] identifyUserWithExternalID:externalId restoreID:nil];
    [self sendResponseSuccessJavascript:@"ExternalId updated" ForCommand:command];
}

- (void) restoreUser:(CDVInvokedUrlCommand*) command {
    NSArray* arguments = [command arguments];

    // Return a error when missed parameters
    if (arguments == nil || arguments.count < 2) {
        [self sendResponseErrorJavascript:@"Some arguments missed, verify please" ForCommand:command];
        return;
    }

    NSString* externalId = [arguments objectAtIndex:0];
    if (externalId == nil) {
        [self sendResponseErrorJavascript:@"For restore user must be include the externalId" ForCommand:command];
        return;
    }

    NSString* restoreId = [arguments objectAtIndex:1];
    if (restoreId == nil) {
        [self sendResponseErrorJavascript:@"For restore user must be include the restoreId" ForCommand:command];
        return;
    }

    [[Freshchat sharedInstance] identifyUserWithExternalID:externalId restoreID:restoreId];
    [self sendResponseSuccessJavascript:@"User restored" ForCommand:command];
    return;
}

- (void) showConversations:(CDVInvokedUrlCommand*) command {
    NSArray* arguments = [command arguments];

    if (arguments != nil && arguments.count > 0) {
        ConversationOptions *options = [ConversationOptions new];
        NSDictionary* conversationParams = [arguments firstObject];

        NSMutableArray *tagsList = [NSMutableArray array];
        NSArray* tags = [conversationParams objectForKey:@"tags"];

        if (tags != nil && tags.count > 0) {
            for (int i = 0; i < tags.count; i++) {
                [tagsList addObject:[tags objectAtIndex:i]];
            }

            NSString* title = [conversationParams objectForKey:@"filteredViewTitle"];
            [options filterByTags:tagsList withTitle:title];
        }

        [[Freshchat sharedInstance] showConversations:[self viewController] withOptions: options];

        [self sendResponseSuccessJavascript:@"Conversations started with options" ForCommand:command];
        return;
    } else {
        [[Freshchat sharedInstance] showConversations:[self viewController]];
        [self sendResponseSuccessJavascript:@"Conversations started" ForCommand:command];
        return;
    }
}

- (void) unreadCount:(CDVInvokedUrlCommand*) command {
    [[Freshchat sharedInstance]unreadCountWithCompletion:^(NSInteger count) {
        NSLog(@"your unread count : %d", (int)count);

        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:(int)count];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        return;
    }];
}

- (void) showFAQs:(CDVInvokedUrlCommand*) command {
    NSArray* arguments = [command arguments];

    if (arguments != nil && arguments.count > 0) {
        NSDictionary* faqParams = [arguments firstObject];
        FAQOptions *options = [FAQOptions new];

        NSMutableArray *tagsList = [NSMutableArray array];
        NSArray* tags = [faqParams objectForKey:@"tags"];
        NSString* articleType = [faqParams objectForKey:@"articleType"];
        
        if (tags != nil && tags.count > 0) {
            for (int i = 0; i < tags.count; i++) {
                [tagsList addObject:[tags objectAtIndex:i]];
            }

            NSString* title = [faqParams objectForKey:@"filteredViewTitle"];

            if ([articleType isEqualToString:@"category"]) {
                [options filterByTags:tagsList withTitle:title andType: CATEGORY];
            } else {
                [options filterByTags:tagsList withTitle:title andType: ARTICLE];
            }
        }

        NSMutableArray *contactusTagsList = [NSMutableArray array];
        NSArray* contactusTags = [faqParams objectForKey:@"contactusTags"];

        if (contactusTags != nil && contactusTags.count > 0) {
            for (int i = 0; i < contactusTags.count; i++) {
                [contactusTagsList addObject:[contactusTags objectAtIndex:i]];
            }

            NSString* contactusTitle = [faqParams objectForKey:@"contactusFilterTitle"];
            [options filterContactUsByTags:contactusTagsList withTitle:contactusTitle];
        }

        [[Freshchat sharedInstance]showFAQs:[self viewController] withOptions:options];

        [self sendResponseSuccessJavascript:@"FAQs started with options" ForCommand:command];
        return;
    } else {
        [[Freshchat sharedInstance]showFAQs:[self viewController]];

        [self sendResponseSuccessJavascript:@"FAQs started" ForCommand:command];
        return;
    }
}

- (void) sendMessage:(CDVInvokedUrlCommand*) command {
    NSArray* arguments = [command arguments];

    // Return a error when missed parameters
    if (arguments == nil || arguments.count < 2) {
        [self sendResponseErrorJavascript:@"Some arguments missed, verify please" ForCommand:command];
        return;
    }

    NSString* message = [arguments objectAtIndex:0];
    if (message == nil) {
        [self sendResponseErrorJavascript:@"For send message must be include the message" ForCommand:command];
        return;
    }

    NSString* tag = [arguments objectAtIndex:1];
    if (tag == nil) {
        [self sendResponseErrorJavascript:@"For send message must be include the tag" ForCommand:command];
        return;
    }

    FreshchatMessage *userMessage = [[FreshchatMessage alloc] initWithMessage:message andTag:tag];
    [[Freshchat sharedInstance] sendMessage:userMessage];

    [self sendResponseSuccessJavascript:@"Message send" ForCommand:command];
    return;
}

@end

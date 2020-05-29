var exec = require('cordova/exec');
var PLUGIN_NAME = 'Freshchat2';

var Freshchat2 = {};

Freshchat2.init = function(config, success, error) {
    exec(success, error, PLUGIN_NAME, "init", [config]);
};

Freshchat2.updateUser = function(user, success, error) {
    exec(success, error, PLUGIN_NAME, "updateUser", [user]);
};

Freshchat2.updateUserProperties = function(properties, success, error) {
    exec(success, error, PLUGIN_NAME, "updateUserProperties", [properties]);
};

Freshchat2.logUserEvent = function(name, values, success, error) {
    exec(success, error, PLUGIN_NAME, "logUserEvent", [name, values]);
};

Freshchat2.resetUserData = function(success, error) {
    exec(success, error, PLUGIN_NAME, "resetUserData", []);
}

Freshchat2.getRestoreId = function(success, error) {
    exec(success, error, PLUGIN_NAME, "getRestoreId", []);
}

Freshchat2.setExternalId = function(externalId, success, error) {
    exec(success, error, PLUGIN_NAME, "setExternalId", [externalId]);
}

Freshchat2.restoreUser = function(externalId, restoreId, success, error) {
    exec(success, error, PLUGIN_NAME, "restoreUser", [externalId, restoreId]);
}

Freshchat2.showConversations = function(options, success, error) {
    var arguments = (options == null || options == undefined) ? [] : [options];
    
    exec(success, error, PLUGIN_NAME, "showConversations", arguments);
};

Freshchat2.unreadCount = function(success, error) {
    exec(success, error, PLUGIN_NAME, "unreadCount", []);
};

Freshchat2.showFAQs = function(options, success, error) {
    var arguments = (options == null || options == undefined) ? [] : [options];
    
    exec(success, error, PLUGIN_NAME, "showFAQs", arguments);
};

Freshchat2.sendMessage = function(message, tag, success, error) {
    exec(success, error, PLUGIN_NAME, "sendMessage", [message, tag]);
};

module.exports = Freshchat2;

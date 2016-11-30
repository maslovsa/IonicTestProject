cordova.define("com.rokolabs.rokomobi.rokomobi", function(require, exports, module) {

module.exports = {
    // Param - link, Success - "name", "createDate", "updateDate", "shareChannel", "vanityLink", "customDomainLink", "type"(ROKOLinkType), "referralCode", "promo"
    handleDeepLink: function (param, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "LinkManager", "handleDeepLink", [param]);
    },
    // Param - "name", "type"(ROKOLinkType), "sourceURL", "channelName", "sharingCode", "advancedSettings", Success - "linkURL", "linkId"
    createLink: function (param, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "LinkManager", "createLink", [param]);
    },
    // Param - "displayMessage", "text", "contentTitle", "contentURL", "ShareChannelTypeFacebook" (and other text fo different Sharing Types)
    shareWithUI: function (param, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "ShareManager", "shareWithUI", [param]);
    },
    //Param - "channelType" ["sms", "twitter", "facebook", "email", "copy"]
    shareCompleteForChannel: function (param, successCallback, errorCallback){
        cordova.exec(successCallback, errorCallback, "ShareManager", "shareCompleteForChannel",[param]);
    },
    // Param - "name", "params"-Dictionary
    addEvent: function (param, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "LoggerManager", "addEvent", [param]);
    },
    // Param - promoCode, Success - array of objects: "applicability", "startDate", "endDate", "isAlwaysActive", "isSingleUseOnly", "autoApplyOnAppOpen", "cannotBeCombined"
    loadPromo: function (param, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "PromoManager", "loadPromo", [param]);
    },
    // Param - promoCode, OPTIONAL: "valueOfPurchase", "valueOfDiscount", deliveryType(ROKOPromoDeliveryType)
    markPromoCodeAsUsed: function (param, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "PromoManager", "markPromoCodeAsUsed", [param]);
    },
    // Param - Empty, Success - array of objects: "createDate", "updateDate", "value", "limit", "type", "canBeUsed"
    loadReferralDiscountsList: function (param, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "ReferralManager", "loadReferralDiscountsList", [param]);
    },
    // Param - discountId
    markReferralDiscountAsUsed: function (param, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "ReferralManager", "markReferralDiscountAsUsed", [param]);
    },
    // Param - "code", Success - "active", "name", "recipientDiscount"-Dictionary, "rewardDiscount"-Dictionary
    loadDiscountInfoWithCode: function (param, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "ReferralManager", "loadDiscountInfoWithCode", [param]);
    },
    // Param - "code", Success - discountId
    activateDiscountWithCode: function (param, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "ReferralManager", "activateDiscountWithCode", [param]);
    },
    // Param - "code", Sucess - "discountId", "referrerId"
    completeDiscountWithCode: function (param, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "ReferralManager", "completeDiscountWithCode", [param]);
    },
    // Param - Empty, Sucess - always
    inviteFriends: function (param, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "ReferralManager", "inviteFriends", [param]);
    },
    // Param - "userName", "password"
    login: function (param, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "PortalManager", "login", [param]);
    },
    // Param - "userName", OPTIONAL: "referralCode", "shareChannel"
    setUser: function (param, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "PortalManager", "setUser", [param]);
    },
    // Param - Empty
    logout: function (param, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "PortalManager", "logout", [param]);
    },// Param - "userName", "email", "password", OPTIONAL: "ambassadorCode", "linkShareChannel"
    signupUser: function (param, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "PortalManager", "signupUser", [param]);
    },
    // Param - Empty, Success - ["version", "applicationName"]
    getPortalInfo: function (param, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "PortalManager", "getPortalInfo", [param]);
    },
    // Param - Empty, Success - ["sessionKey", "expirationDate", "expirationDate", "user"-Dictionary]
    getSessionInfo: function (param, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "PortalManager", "getSessionInfo", [param]);
    },
    // Param - Empty, Success - ["objectId", "createDate", "email", "firstLoginTime", "lastLoginTime", "phone", "photoFile", "referralCode", "updateDate", "username"
    getUserInfo: function (param, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "PortalManager", "getUserInfo", [param]);
    },
    // Param - "newValue", "key", Success - "Set User Custom Property Successful"
    setUserCustomProperty: function (param, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "PortalManager", "setUserCustomProperty", [param]);
    },
    // Param - Sring of push data, Success - promoCode
    promoCodeFromNotification: function (param, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "PushManager", "promoCodeFromNotification", [param]);
    },
    ROKOLinkType: {
        ROKOLinkTypeManual: 0,
        ROKOLinkTypePromo: 1,
        ROKOLinkTypeReferral: 2,
        ROKOLinkTypeShare: 3
    },
    ROKOPromoDeliveryType: {
        ROKOPromoDeliveryTypeUnknown: 0,
        ROKOPromoDeliveryTypePush: 1,
        ROKOPromoDeliveryTypeEvent: 2,
        ROKOPromoDeliveryTypeLink: 3
    }
};

});

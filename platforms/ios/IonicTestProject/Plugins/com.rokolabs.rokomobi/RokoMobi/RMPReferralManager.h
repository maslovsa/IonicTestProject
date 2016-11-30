#import <Cordova/CDV.h>
#import "RMPHelper.h"

@interface RMPReferralManager : RMPHelper

- (void)loadReferralDiscountsList:(CDVInvokedUrlCommand *)command;

- (void)markReferralDiscountAsUsed:(CDVInvokedUrlCommand *)command;

- (void)loadDiscountInfoWithCode:(CDVInvokedUrlCommand *)command;

- (void)activateDiscountWithCode:(CDVInvokedUrlCommand *)command;

- (void)completeDiscountWithCode:(CDVInvokedUrlCommand *)command;

- (void)inviteFriends:(CDVInvokedUrlCommand *)command;
@end

#import <Cordova/CDV.h>
#import "RMPHelper.h"

@interface RMPPortalManager : RMPHelper

- (void)login:(CDVInvokedUrlCommand *)command;
- (void)setUser:(CDVInvokedUrlCommand *)command;
- (void)logout:(CDVInvokedUrlCommand *)command;
- (void)signupUser:(CDVInvokedUrlCommand *)command;
- (void)getPortalInfo:(CDVInvokedUrlCommand *)command;
- (void)getSessionInfo:(CDVInvokedUrlCommand *)command;
- (void)getUserInfo:(CDVInvokedUrlCommand *)command;
- (void)setUserCustomProperty:(CDVInvokedUrlCommand *)command;

@end

#import <Cordova/CDV.h>
#import "RMPHelper.h"

@interface RMPLinkManager : RMPHelper

- (void)handleDeepLink:(CDVInvokedUrlCommand *)command;
- (void)createLink:(CDVInvokedUrlCommand *)command;

@end

#import <Cordova/CDV.h>
#import "RMPHelper.h"

@interface RMPLoggerManager : RMPHelper

- (void)addEvent:(CDVInvokedUrlCommand *)command;

@end

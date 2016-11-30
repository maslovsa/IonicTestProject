#import <UIKit/UIKit.h>
#import "RMPLoggerManager.h"
#import <ROKOMobi/ROKOMobi.h>


@interface RMPLoggerManager () {
}
@end

@implementation RMPLoggerManager

- (void)pluginInitialize {
    [super pluginInitialize];
}

- (void)addEvent:(CDVInvokedUrlCommand *)command {
    [self parseCommand:command];
    NSDictionary *params = command.arguments[0];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Failed"];
    
    if (params && params[@"name"]) {
        NSString *eventName = params[@"name"];
        NSDictionary *parameters = [self dictionaryValue:params forKey:@"params"];
        [[ROKOLogger sharedLogger] addEvent:eventName withParameters:parameters];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Done"];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.command.callbackId];
}

@end

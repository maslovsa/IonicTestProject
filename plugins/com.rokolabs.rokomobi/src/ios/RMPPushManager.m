#import <UIKit/UIKit.h>
#import "RMPPushManager.h"
#import <ROKOMobi/ROKOMobi.h>


@interface RMPPushManager () {
}
@end

@implementation RMPPushManager

- (void)pluginInitialize {
    [super pluginInitialize];
}

- (void)promoCodeFromNotification:(CDVInvokedUrlCommand *)command {
[self parseCommand:command];
        NSString *jsonString =  command.arguments[0];
        
        if (jsonString) {
            NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if (json) {
                ROKOPush *push = [[ROKOPush alloc] init];
                NSString *promoCode = [push promoCodeFromNotification: json];
                CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: promoCode];
                [self.commandDelegate sendPluginResult:result callbackId:self.command.callbackId];
            } else {
                CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Bad JSON Parsing"];
                [self.commandDelegate sendPluginResult:result callbackId:self.command.callbackId];
            }
        } else {
            CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Bad Param"];
            [self.commandDelegate sendPluginResult:result callbackId:self.command.callbackId];
        }

}

- (void)initPush:(CDVInvokedUrlCommand *)command {
    [self parseCommand:command];
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"Ok"];
    [self.commandDelegate sendPluginResult:result callbackId:self.command.callbackId];
}
@end

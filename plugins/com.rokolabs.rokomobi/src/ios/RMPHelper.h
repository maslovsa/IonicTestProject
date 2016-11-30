#import <Cordova/CDV.h>
#import <ROKOMobi/ROKOMobi.h>

@interface RMPHelper : CDVPlugin

@property (strong, nonatomic) CDVInvokedUrlCommand *command;

- (BOOL)parseCommand:(CDVInvokedUrlCommand *)command;
- (ROKOLinkType)numberToROKOLinkType:(NSNumber *)linkType;
- (NSDictionary *)dictionaryValue:(NSDictionary *)dictionary forKey:(NSString *)key;
- (void)handleError:(NSError *)error;
- (void)handleBadParamError:(NSString *)description;
@end

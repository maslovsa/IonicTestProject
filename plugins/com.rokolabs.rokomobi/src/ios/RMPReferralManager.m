#import <UIKit/UIKit.h>
#import "RMPReferralManager.h"
#import <ROKOMobi/ROKOMobi.h>
#import "ROKOReferralDiscountItem+ROKOReferralDiscountItemMapper.h"
#import "ROKOReferralCampaignInfo+ROKOReferralCampaignInfoMapper.h"

@interface RMPReferralManager () {

}
@end

@implementation RMPReferralManager

- (void)pluginInitialize {
    [super pluginInitialize];
}

- (void)loadReferralDiscountsList:(CDVInvokedUrlCommand *)command {
[self parseCommand:command];
        __weak __typeof__(self) weakSelf = self;
        
        ROKOReferral *referral = [[ROKOReferral alloc] init];
        [referral loadReferralDiscountsList:^(NSArray *items, NSError *error) {
            if (error) {
                [weakSelf handleError:error];
            } else {
                NSMutableArray *referralDiscountItems = [[NSMutableArray alloc] init];
                
                for (ROKOReferralDiscountItem *item in items) {
                    NSDictionary *representation = [EKSerializer serializeObject:item withMapping:[ROKOReferralDiscountItem objectMapping]];
                    [referralDiscountItems addObject:representation];
                }
                
                CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:referralDiscountItems];
                [weakSelf.commandDelegate sendPluginResult:result callbackId:weakSelf.command.callbackId];
            }
        }];

}

- (void)markReferralDiscountAsUsed:(CDVInvokedUrlCommand *)command {
[self parseCommand:command];
        NSNumber *discountId = command.arguments[0];
        
        if (discountId) {
            __weak __typeof__(self) weakSelf = self;
            
            ROKOReferral *referral = [[ROKOReferral alloc] init];
            [referral markReferralDiscountAsUsed:discountId completionBlock:^(NSError *error) {
                if (error) {
                    [weakSelf handleError:error];
                } else {
                    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Referral discount has been marked as used. Please refresh view."];
                    [weakSelf.commandDelegate sendPluginResult:result callbackId:weakSelf.command.callbackId];
                }
            }];
        }

}

- (void)loadDiscountInfoWithCode:(CDVInvokedUrlCommand *)command {
[self parseCommand:command];
        NSString *code = command.arguments[0];
        
        if (code) {
            __weak __typeof__(self) weakSelf = self;
            
            ROKOReferral *referral = [[ROKOReferral alloc] init];
            [referral loadDiscountInfoWithCode:code completionBlock:^(ROKOReferralCampaignInfo *discount, NSError *error) {
                if (error) {
                    [weakSelf handleError:error];
                } else {
                    NSDictionary *representation = [EKSerializer serializeObject:discount withMapping:[ROKOReferralCampaignInfo objectMapping]];
                    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:representation];
                    [weakSelf.commandDelegate sendPluginResult:result callbackId:weakSelf.command.callbackId];
                }
            }];
        }

}

- (void)activateDiscountWithCode:(CDVInvokedUrlCommand *)command {
[self parseCommand:command];
        NSString *code = command.arguments[0];
        
        if (code) {
            __weak __typeof__(self) weakSelf = self;
            
            ROKOReferral *referral = [[ROKOReferral alloc] init];
            [referral activateDiscountWithCode:code completionBlock:^(NSNumber *discountId, NSError *error) {
                if (error) {
                    [weakSelf handleError:error];
                } else {
                    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsNSInteger:[discountId integerValue]];
                    [weakSelf.commandDelegate sendPluginResult:result callbackId:weakSelf.command.callbackId];
                }
            }];
        }

}

- (void)completeDiscountWithCode:(CDVInvokedUrlCommand *)command {
[self parseCommand:command];
        NSString *code = command.arguments[0];
        
        if (code) {
            __weak __typeof__(self) weakSelf = self;
            
            ROKOReferral *referral = [[ROKOReferral alloc] init];
            [referral completeDiscountWithCode:code completionBlock:^(NSNumber *discountId, NSNumber *referrerId, NSError *error) {
                if (error) {
                    [weakSelf handleError:error];
                } else {
                    NSDictionary *dictionary = @{@"discountId": discountId,
                                                 @"referrerId": referrerId};
                    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dictionary];
                    [weakSelf.commandDelegate sendPluginResult:result callbackId:weakSelf.command.callbackId];
                }
            }];
        }

}

- (void)inviteFriends:(CDVInvokedUrlCommand *)command {
    [self parseCommand:command];

    ROKOInviteFriendsViewController* inviteFriendsController = [ROKOInviteFriendsViewController buildController];
    [self.viewController presentViewController:inviteFriendsController animated:YES completion:nil];

    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Referral discount has been marked as used. Please refresh view."];
    [self.commandDelegate sendPluginResult:result callbackId:self.command.callbackId];
}
@end

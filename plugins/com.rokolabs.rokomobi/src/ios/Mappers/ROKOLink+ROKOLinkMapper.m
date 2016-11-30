//
//  ROKOLink_ROKOLinkMapper.m
//  HelloRoko
//
//  Created by Maslov Sergey on 15.04.16.
//
//

#import "ROKOLink+ROKOLinkMapper.h"
#import <Foundation/NSFormatter.h>

@implementation ROKOLink (ROKOLinkMapping)

+ (EKObjectMapping *)objectMapping {
  return [EKObjectMapping mappingForClass:self withBlock:^(EKObjectMapping *mapping) {
      [mapping mapPropertiesFromArray:@[@"name", @"shareChannel", @"vanityLink", @"customDomainLink", @"referralCode", @"promoCode", @"settings"]];

        [mapping mapKeyPath:@"createDate" toProperty:@"createDate" withDateFormatter:[NSDateFormatter ek_formatterForCurrentThread]];
        [mapping mapKeyPath:@"updateDate" toProperty:@"updateDate" withDateFormatter:[NSDateFormatter ek_formatterForCurrentThread]];
        
        
        NSDictionary *genders = @{ @"ROKOLinkTypeManual": @(ROKOLinkTypeManual),
                                   @"ROKOLinkTypePromo": @(ROKOLinkTypePromo),
                                   @"ROKOLinkTypeReferral": @(ROKOLinkTypeReferral),
                                   @"ROKOLinkTypeShare": @(ROKOLinkTypeShare)};
        
        [mapping mapKeyPath:@"type" toProperty:@"type" withValueBlock:^(NSString *key, id value) {
            return genders[value];
        } reverseBlock:^id(id value) {
            return [genders allKeysForObject:value].lastObject;
        }];
        

  }];
}

@end

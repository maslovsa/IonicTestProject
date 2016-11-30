//
//  ROKOReferralDiscountItem+ROKOReferralDiscountItemMapper.h
//  HelloRoko
//
//  Created by Maslov Sergey on 30.05.16.
//
//

#import "ROKOReferralDiscountItem+ROKOReferralDiscountItemMapper.h"
#import <Foundation/NSFormatter.h>

@implementation ROKOReferralDiscountItem (ROKOReferralDiscountItemMapper)

+ (EKObjectMapping *)objectMapping {
  return [EKObjectMapping mappingForClass:self withBlock:^(EKObjectMapping *mapping) {
        // Base properties
        [mapping mapPropertiesFromArray:@[@"value", @"limit", @"canBeUsed"]];

        NSDictionary *discountTypes = @{ @"ROKODiscountTypeUnspecified": @(ROKODiscountTypeUnspecified),
                                   @"ROKODiscountTypePercent": @(ROKODiscountTypePercent),
                                   @"ROKODiscountTypeFixed": @(ROKODiscountTypeFixed),
                                   @"ROKODiscountTypeFree": @(ROKODiscountTypeFree),
                                   @"ROKODiscountTypeMatching": @(ROKODiscountTypeMatching)};
        
        [mapping mapKeyPath:@"type" toProperty:@"type" withValueBlock:^(NSString *key, id value) {
            return discountTypes[value];
        } reverseBlock:^id(id value) {
            return [discountTypes allKeysForObject:value].firstObject;
        }];

        // Local properties
        [mapping mapKeyPath:@"createDate" toProperty:@"createDate" withDateFormatter:[NSDateFormatter ek_formatterForCurrentThread]];
        [mapping mapKeyPath:@"updateDate" toProperty:@"updateDate" withDateFormatter:[NSDateFormatter ek_formatterForCurrentThread]];
  }];
}

@end

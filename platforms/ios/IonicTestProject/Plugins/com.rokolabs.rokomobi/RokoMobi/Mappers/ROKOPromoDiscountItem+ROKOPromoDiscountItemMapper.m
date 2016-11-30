//
//  ROKOPromoDiscountItem+ROKOPromoDiscountItemMapper.h
//  HelloRoko
//
//  Created by Maslov Sergey on 30.05.16.
//
//

#import "ROKOPromoDiscountItem+ROKOPromoDiscountItemMapper.h"
#import <Foundation/NSFormatter.h>

@implementation ROKOPromoDiscountItem (ROKOPromoDiscountItemMapper)

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
        [mapping mapPropertiesFromArray:@[@"isAlwaysActive", @"isSingleUseOnly", @"autoApplyOnAppOpen", @"cannotBeCombined"]];

        [mapping mapKeyPath:@"startDate" toProperty:@"startDate" withDateFormatter:[NSDateFormatter ek_formatterForCurrentThread]];
        [mapping mapKeyPath:@"endDate" toProperty:@"endDate" withDateFormatter:[NSDateFormatter ek_formatterForCurrentThread]];
        
        NSDictionary *applicabilityTypes = @{ @"ROKOPromoDiscountApplicabilityUnspecified": @(ROKOPromoDiscountApplicabilityUnspecified),
                                   @"ROKOPromoDiscountApplicabilityAllUsers": @(ROKOPromoDiscountApplicabilityAllUsers),
                                   @"ROKOPromoDiscountApplicabilitySegments": @(ROKOPromoDiscountApplicabilitySegments)};
        
        [mapping mapKeyPath:@"applicability" toProperty:@"applicability" withValueBlock:^(NSString *key, id value) {
            return applicabilityTypes[value];
        } reverseBlock:^id(id value) {
            return [applicabilityTypes allKeysForObject:value].firstObject;
        }];

  }];
}

@end

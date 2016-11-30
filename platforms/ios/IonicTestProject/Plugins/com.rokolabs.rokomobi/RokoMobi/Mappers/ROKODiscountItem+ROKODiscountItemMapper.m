//
//  ROKODiscountItem+ROKOPromoDiscountItemMapper.h
//  HelloRoko
//
//  Created by Maslov Sergey on 30.05.16.
//
//

#import "ROKODiscountItem+ROKODiscountItemMapper.h"
#import <Foundation/NSFormatter.h>

@implementation ROKODiscountItem (ROKODiscountItemMapper)

+ (EKObjectMapping *)objectMapping {
  return [EKObjectMapping mappingForClass:self withBlock:^(EKObjectMapping *mapping) {
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

  }];
}

@end

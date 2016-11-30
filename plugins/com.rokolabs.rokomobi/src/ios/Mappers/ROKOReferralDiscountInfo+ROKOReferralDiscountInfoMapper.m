//
//  ROKOReferralDiscountInfo+ROKOReferralDiscountInfoMapper.h
//  HelloRoko
//
//  Created by Maslov Sergey on 30.05.16.
//
//

#import "ROKOReferralDiscountInfo+ROKOReferralDiscountInfoMapper.h"
#import <Foundation/NSFormatter.h>

@implementation ROKOReferralDiscountInfo (ROKOReferralDiscountInfoMapper)

+ (EKObjectMapping *)objectMapping {
  return [EKObjectMapping mappingForClass:self withBlock:^(EKObjectMapping *mapping) {
      [mapping mapPropertiesFromArray:@[@"value", @"limit", @"enabled"]];

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

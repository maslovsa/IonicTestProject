//
//  ROKOReferralCampaignInfo+ROKOReferralCampaignInfoMapper.h
//  HelloRoko
//
//  Created by Maslov Sergey on 30.05.16.
//
//

#import "ROKOReferralCampaignInfo+ROKOReferralCampaignInfoMapper.h"
#import <Foundation/NSFormatter.h>

@implementation ROKOReferralCampaignInfo (ROKOReferralCampaignInfoMapper)

+ (EKObjectMapping *)objectMapping {
  return [EKObjectMapping mappingForClass:self withBlock:^(EKObjectMapping *mapping) {
      [mapping mapPropertiesFromArray:@[@"active", @"name"]];

      [mapping hasOne:[ROKOReferralDiscountInfo class] forKeyPath:@"recipientDiscount"];
      [mapping hasOne:[ROKOReferralDiscountInfo class] forKeyPath:@"rewardDiscount"];
  }];
}

@end

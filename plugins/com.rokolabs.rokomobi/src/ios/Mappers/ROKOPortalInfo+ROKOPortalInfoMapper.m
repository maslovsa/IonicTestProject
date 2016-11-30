//
//  ROKOPortalInfo_ROKOPortalInfoMapper.m
//  HelloRoko
//
//  Created by Maslov Sergey on 15.04.16.
//
//

#import "ROKOPortalInfo+ROKOPortalInfoMapper.h"
#import <Foundation/NSFormatter.h>

@implementation ROKOPortalInfo (ROKOPortalInfoMapping)

+ (EKObjectMapping *)objectMapping {
  return [EKObjectMapping mappingForClass:self withBlock:^(EKObjectMapping *mapping) {
      [mapping mapPropertiesFromArray:@[@"version", @"applicationName"]];
  }];
}

@end

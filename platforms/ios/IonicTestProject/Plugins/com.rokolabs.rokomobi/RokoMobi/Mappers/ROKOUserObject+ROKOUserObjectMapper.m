//
//  ROKOUserObject_ROKOUserObjectMapper.m
//  HelloRoko
//
//  Created by Maslov Sergey on 15.04.16.
//
//

#import "ROKOUserObject+ROKOUserObjectMapper.h"
#import <Foundation/NSFormatter.h>

@implementation ROKOUserObject (ROKOUserObjectMapping)

+ (EKObjectMapping *)objectMapping {
  return [EKObjectMapping mappingForClass:self withBlock:^(EKObjectMapping *mapping) {
      [mapping mapPropertiesFromArray:@[@"objectId", @"createDate", @"email", @"firstLoginTime", @"lastLoginTime", @"phone", @"photoFile", @"referralCode", @"updateDate", @"username", @"customProperties", @"systemProperties"]];
  }];
}

@end

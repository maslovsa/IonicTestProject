//
//  ROKOSessionInfo_ROKOSessionInfoMapper.m
//  HelloRoko
//
//  Created by Maslov Sergey on 15.04.16.
//
//

#import "ROKOSessionInfo+ROKOSessionInfoMapper.h"
#import <Foundation/NSFormatter.h>

@implementation ROKOSessionInfo (ROKOSessionInfoMapping)

+ (EKObjectMapping *)objectMapping {
  return [EKObjectMapping mappingForClass:self withBlock:^(EKObjectMapping *mapping) {
      [mapping mapPropertiesFromArray:@[@"sessionKey"]];

        [mapping mapKeyPath:@"expirationDate" toProperty:@"expirationDate" withDateFormatter:[NSDateFormatter ek_formatterForCurrentThread]];
        [mapping hasOne:[ROKOUserObject class] forKeyPath:@"user"];
  }];
}

@end

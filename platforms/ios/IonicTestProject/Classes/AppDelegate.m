/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

//
//  AppDelegate.m
//  upace
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___ORGANIZATIONNAME___ ___YEAR___. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import <ROKOMobi/ROKOMobi.h>
#import "ROKOLink+ROKOLinkMapper.h"


#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface AppDelegate ()

@property (nonatomic, strong) ROKOPush *pushComponent;

@end;

@implementation AppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0")){
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if( !error ){
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
        }];
    } else {
        // Register for Apple Remote Push Notifications
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [application registerForRemoteNotifications];
    }
    
    // Handle the case when application has opened from click on notification
    NSDictionary *remoteNotificationInfo = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
    if (remoteNotificationInfo) {
        [self application:application didReceiveRemoteNotification:remoteNotificationInfo];
    }
    
    self.viewController = [[MainViewController alloc] init];
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    self.pushComponent = [[ROKOPush alloc]init];
    [self.pushComponent registerWithAPNToken:deviceToken withCompletion:^(id responseObject, NSError *error) {
        if (error){
            NSLog(@"Failed to register with error - %@", error);
        } else {
            NSLog(@"Success registration for push - %@", responseObject);
        }
    }];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError with error - %@", error);
    
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    
    //Called when a notification is delivered to a foreground app.
    
    NSLog(@"Userinfo %@",notification.request.content.userInfo);
    [self.pushComponent handleNotification: notification.request.content.userInfo];
    completionHandler(UNNotificationPresentationOptionAlert);
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    
    //Called to let your app know which action was selected by the user for a given notification.
    [self.pushComponent handleNotification: response.notification.request.content.userInfo];
    NSLog(@"Userinfo %@",response.notification.request.content.userInfo);
    
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [self application:application didReceiveRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [self.pushComponent handleNotification:userInfo];
    
    NSString *json = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:userInfo options:1 error:nil] encoding:4];
    NSLog(@"push json - %@", json);
    CDVViewController *conroller = (CDVViewController*)self.window.rootViewController;
    UIWebView *webView = (UIWebView*)conroller.webView;
    [webView stringByEvaluatingJavaScriptFromString: [NSString stringWithFormat:@"onRecievePushNotification(%@)", json] ];
}

@end

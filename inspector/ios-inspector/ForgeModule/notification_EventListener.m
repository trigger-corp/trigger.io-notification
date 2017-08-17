//
//  notification_EventListener.m
//  ForgeModule
//
//  Created by Antoine van Gelder on 2016/09/23.
//  Copyright © 2016 Trigger Corp. All rights reserved.
//

#import "notification_EventListener.h"
#import "notification_Delegate.h"

@implementation notification_EventListener

#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{

    if (SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0")) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = [[notification_Delegate alloc] init];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound |
                                                 UNAuthorizationOptionAlert |
                                                 UNAuthorizationOptionBadge)
                              completionHandler:^(BOOL granted, NSError * _Nullable error){
            if (error != nil) {
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
        }];  
    } else {
        // Older iOS versions still use the existing code
    }
    
    return YES;
}

@end

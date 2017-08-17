//
//  notification_Delegate.m
//  ForgeModule
//
//  Created by Antoine van Gelder on 2016/09/23.
//  Copyright © 2016 Trigger Corp. All rights reserved.
//

#import "notification_Delegate.h"

// http://stackoverflow.com/questions/39490605/push-notification-issue-with-ios-10

@implementation notification_Delegate

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    // handle
    completionHandler(UNNotificationPresentationOptionAlert);
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler {
    // handle
}

@end

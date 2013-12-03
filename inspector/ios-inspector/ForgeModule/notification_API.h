//
//  notification_API.h
//  Forge
//
//  Created by Connor Dunn on 14/03/2012.
//  Copyright (c) 2012 Trigger Corp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface notification_API : NSObject

+ (void)create:(ForgeTask*)task title:(NSString*)title text:(NSString*)text;

+ (void)setBadgeNumber:(ForgeTask*)task number:(NSNumber*)number;

@end

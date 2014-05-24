//
//  notification_API.m
//  Forge
//
//  Created by Connor Dunn on 14/03/2012.
//  Copyright (c) 2012 Trigger Corp. All rights reserved.
//

#import "notification_API.h"
#import "RIButtonItem.h"
#import "UIAlertView+Blocks.h"
#import "PCToastMessage.h"
#import "CustomIOS7AlertView.h"

static NSObject *loading;

@implementation notification_API

+ (void)create:(ForgeTask*)task title:(NSString*)title text:(NSString*)text {
	RIButtonItem *ok = [RIButtonItem item];
	ok.label = @"OK";
	ok.action = ^{
		[task success:nil];
	};
	[[[UIAlertView alloc] initWithTitle:title message:text cancelButtonItem:ok otherButtonItems:nil] show];
}

+ (void)setBadgeNumber:(ForgeTask*)task number:(NSNumber*)number {
	[UIApplication sharedApplication].applicationIconBadgeNumber = [number intValue];
	[task success:nil];
}

+ (void)getBadgeNumber:(ForgeTask*)task {
	NSInteger number = [UIApplication sharedApplication].applicationIconBadgeNumber;
	[task success:[NSNumber numberWithInteger:number]];
}

+ (void)alert:(ForgeTask*)task title:(NSString*)title body:(NSString*)body {
	RIButtonItem *ok = [RIButtonItem item];
	ok.label = @"OK";
	ok.action = ^{
		[task success:nil];
	};
	[[[UIAlertView alloc] initWithTitle:title message:body cancelButtonItem:ok otherButtonItems:nil] show];
}

+ (void)confirm:(ForgeTask*)task title:(NSString*)title body:(NSString*)body positive:(NSString*)positive negative:(NSString*)negative {
	RIButtonItem *positiveBtn = [RIButtonItem item];
	positiveBtn.label = positive;
	positiveBtn.action = ^{
		[task success:@YES];
	};
	RIButtonItem *negativeBtn = [RIButtonItem item];
	negativeBtn.label = negative;
	negativeBtn.action = ^{
		[task success:@NO];
	};
	[[[UIAlertView alloc] initWithTitle:title message:body cancelButtonItem:negativeBtn otherButtonItems:positiveBtn, nil] show];
}

+ (void)prompt:(ForgeTask*)task title:(NSString*)title body:(NSString*)body {
  RIButtonItem *ok = [RIButtonItem item];
  ok.label = @"OK";
  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:body cancelButtonItem:ok otherButtonItems:nil];
  UITextField *input = [alertView textFieldAtIndex:0];
  ok.action = ^{
    [task success:input.text];
  };
  [alertView show];
}

+ (void)toast:(ForgeTask*)task body:(NSString*)body {
	[PCToastMessage toastWithDuration:5.0 andText:body inView:[[[ForgeApp sharedApp] viewController] view]];
	[task success:nil];

}

+ (void)showLoading:(ForgeTask*)task title:(NSString*)title body:(NSString*)body {
	if (loading != nil) {
		if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
            [(UIAlertView *)loading setTitle:title];
            [(UIAlertView *)loading setMessage:body];
        } else {
            [(CustomIOS7AlertView *)loading setTitle:title];
            [(CustomIOS7AlertView *)loading setMessage:body];
        }
	} else {
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
            loading = [[UIAlertView alloc] initWithTitle:title message:body delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
            [(UIAlertView *)loading show];
            
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            
            indicator.center = CGPointMake(((UIAlertView *)loading).bounds.size.width / 2, ((UIAlertView *)loading).bounds.size.height - 50);
            [indicator startAnimating];
            
            [(UIAlertView *)loading addSubview:indicator];
        } else {
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            
            loading = [[CustomIOS7AlertView alloc] initWithTitleAndActivityIndicator:title message:body activityIndicator:indicator];
            
            [(CustomIOS7AlertView *)loading show];
        }
	}
	
	[task success:nil];
}

+ (void)hideLoading:(ForgeTask*)task {
	if (loading != nil) {
		if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
            [(UIAlertView *)loading dismissWithClickedButtonIndex:0 animated:YES];
        } else {
            [(CustomIOS7AlertView *)loading close];
        }
		loading = nil;
	}
	[task success:nil];
}

@end

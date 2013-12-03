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

static UIAlertView *loading;

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

+ (void)toast:(ForgeTask*)task body:(NSString*)body {
	[PCToastMessage toastWithDuration:5.0 andText:body inView:[[[ForgeApp sharedApp] viewController] view]];
	[task success:nil];

}

+ (void)showLoading:(ForgeTask*)task title:(NSString*)title body:(NSString*)body {
	if (loading != nil) {
		[loading setTitle:title];
		[loading setMessage:body];
	} else {
		loading = [[UIAlertView alloc] initWithTitle:title message:body delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
		[loading show];
	 
		UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	 
		indicator.center = CGPointMake(loading.bounds.size.width / 2, loading.bounds.size.height - 50);
		[indicator startAnimating];
		[loading addSubview:indicator];
	}
	
	[task success:nil];
}

+ (void)hideLoading:(ForgeTask*)task {
	if (loading != nil) {
		[loading dismissWithClickedButtonIndex:0 animated:YES];
		loading = nil;
	}
	[task success:nil];
}

@end

//
//  ACAppDelegate.m
//  SimulatorRemoteNotificationsExample
//
//  Created by Arnaud Coomans on 13/02/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import "ACExampleAppDelegate.h"
#import "ACMainViewController.h"

#if DEBUG
#import "UIApplication+SimulatorRemoteNotifications.h"
#endif


@implementation ACExampleAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
	self.window.rootViewController = [[ACMainViewController alloc] initWithNibName:NSStringFromClass([ACMainViewController class]) bundle:nil];
    [self.window makeKeyAndVisible];

#if DEBUG
	// optional: [application setRemoteNotificationPort:9930];
	[application listenForRemoteNotifications];
#endif
	
    return YES;
}

#pragma mark - remote notifications

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
	NSLog(@"Device token = \"%@\"", [[NSString alloc] initWithData:deviceToken encoding:NSUTF8StringEncoding]);
    
    self.didRegisterForRemoteNotificationsWithDeviceToken = deviceToken;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

	NSLog(@"Remote notification = %@", userInfo);
	
	if ( application.applicationState == UIApplicationStateActive ) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Remote notification received"
														message:[NSString stringWithFormat:@"application:didReceiveRemoteNotification:\n%@", [userInfo description]]
													   delegate:self
											  cancelButtonTitle:@"Got it!"
											  otherButtonTitles:nil];
		[alert show];
	}
    
    self.didReceiveRemoteNotificationUserInfo = userInfo;
}

@end

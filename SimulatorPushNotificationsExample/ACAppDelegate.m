//
//  ACAppDelegate.m
//  SimulatorRemoteNotificationExample
//
//  Created by Arnaud Coomans on 13/02/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import "ACAppDelegate.h"
#import "ACMainViewController.h"

#import "UIApplication+SimulatorRemoteNotification.h"

@implementation ACAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
	self.window.rootViewController = [[ACMainViewController alloc] initWithNibName:NSStringFromClass([ACMainViewController class]) bundle:nil];
    [self.window makeKeyAndVisible];

#if TARGET_IPHONE_SIMULATOR
	// optional: [application setRemoteNotificationPort:9930];
	[application listenForRemoteNotification];
#endif
	
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - push notifications

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
	NSLog(@"Device token = \"%@\"", [[NSString alloc] initWithData:deviceToken encoding:NSUTF8StringEncoding]);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

	NSLog(@"Remote notification = %@", userInfo);
	
	if ( application.applicationState == UIApplicationStateActive ) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Remote notification received"
														message:[userInfo description]
													   delegate:self
											  cancelButtonTitle:@"Got it!"
											  otherButtonTitles:nil];
		[alert show];
	}
}

@end

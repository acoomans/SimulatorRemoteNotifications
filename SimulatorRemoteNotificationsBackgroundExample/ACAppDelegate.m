//
//  ACAppDelegate.m
//  SimulatorRemoteNotificationsBackgroundExample
//
//  Created by Arnaud Coomans on 11/6/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import "ACAppDelegate.h"
#import "ACMainViewController.h"

#if DEBUG
#import "UIApplication+SimulatorRemoteNotifications.h"
#endif


@implementation ACAppDelegate

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
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

    [[NSException exceptionWithName:@"MethodShouldNotHaveBeenCalledException"
                            reason:@"application:didReceiveRemoteNotification: was called instead of application:didReceiveRemoteNotification:fetchCompletionHandler:"
                          userInfo:nil] raise];

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))handler {

    NSLog(@"Remote notification = %@", userInfo);

    if (application.applicationState == UIApplicationStateActive) {

        if ( application.applicationState == UIApplicationStateActive ) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Remote notification received"
                                                            message:[NSString stringWithFormat:@"application:didReceiveRemoteNotification:fetchCompletionHandler:\n%@", [userInfo description]]
                                                           delegate:self
                                                  cancelButtonTitle:@"Got it!"
                                                  otherButtonTitles:nil];
            [alert show];
        }

	} else {
        // app is background, do background stuff
        NSLog(@"Remote notification received while in background");
    }

    handler(UIBackgroundFetchResultNoData);
}

@end
//
//  SimulatorRemoteNotificationsBackgroundExampleTests.m
//  SimulatorRemoteNotificationsBackgroundExampleTests
//
//  Created by Arnaud Coomans on 21/02/14.
//  Copyright (c) 2014 acoomans. All rights reserved.
//

#import "SimulatorRemoteNotificationsBackgroundExampleTests.h"
#import "ACSimulatorRemoteNotificationsService.h"
#import "UIApplication+SimulatorRemoteNotifications.h"
#import "ACBackgroundExampleAppDelegate.h"

@implementation SimulatorRemoteNotificationsBackgroundExampleTests

- (void)testExample {
    
    ACBackgroundExampleAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    NSDictionary *dictionary = @{@"message": @"message"};
    [[ACSimulatorRemoteNotificationsService sharedService] send:dictionary];
    
    NSDate *date = [NSDate date];
	while (YES) {
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
								 beforeDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
		if ([[NSDate date] timeIntervalSinceDate:date] > 1) {
			break;
		}
	}
    
    NSLog(@"didReceiveRemoteNotificationFetchCompletionHandlerUserInfo: %@", appDelegate.didReceiveRemoteNotificationFetchCompletionHandlerUserInfo);
    
    STAssertNotNil(appDelegate.didRegisterForRemoteNotificationsWithDeviceToken, nil);
    STAssertNil(appDelegate.didReceiveRemoteNotificationUserInfo, nil);
    STAssertEqualObjects(dictionary, appDelegate.didReceiveRemoteNotificationFetchCompletionHandlerUserInfo, nil);
}

@end

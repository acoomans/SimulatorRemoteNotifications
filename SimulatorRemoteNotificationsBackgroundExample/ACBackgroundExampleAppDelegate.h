//
//  ACAppDelegate.h
//  SimulatorRemoteNotificationsBackgroundExample
//
//  Created by Arnaud Coomans on 11/6/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACBackgroundExampleAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// used by unit tests
@property (nonatomic, strong) NSData *didRegisterForRemoteNotificationsWithDeviceToken;
@property (nonatomic, strong) NSDictionary *didReceiveRemoteNotificationUserInfo;
@property (nonatomic, strong) NSDictionary *didReceiveRemoteNotificationFetchCompletionHandlerUserInfo;

@end

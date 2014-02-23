//
//  UIApplication+SimulatorRemoteNotifications.h
//  SimulatorRemoteNotifications
//
//  Created by Arnaud Coomans on 13/02/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//


#if defined(__has_include)
#if __has_include(<UIKit/UIKit.h>)
#import <UIKit/UIKit.h>
#define UIKIT_AVAILABLE 1

/** SimulatorRemoteNotifications is a category that adds remote notifications by listening on a UDP port. This makes it effectively possible to receive mock remote notifications in the iOS simulator
 */
@interface UIApplication (SimulatorRemoteNotifications)

/** @name Properties */

/** Remote notification port
 */
@property (nonatomic, assign) NSInteger remoteNotificationsPort;


/** @name Listening to notifications */

/** Start listening for remote notifications
 * @discussion The application will start listening for remote notifications via UDP. You can use the ACSimulatorRemoteNotificationsService to send notification to the application, calling the app delegate's application:didReceiveRemoteNotification:fetchCompletionHandler: (iOS7 and later) or application:didReceiveRemoteNotification: method.
 */
- (void)listenForRemoteNotifications;

@end

#endif
#endif

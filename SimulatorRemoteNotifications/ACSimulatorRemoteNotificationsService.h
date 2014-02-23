//
//  ACSimulatorRemoteNotificationsService.h
//  SimulatorRemoteNotificationsExample
//
//  Created by Arnaud Coomans on 21/02/14.
//  Copyright (c) 2014 acoomans. All rights reserved.
//

#import <Foundation/Foundation.h>

/** ACSimulatorRemoteNotificationsService is a service to send mock remote notifications to SimulatorRemoteNotifications-enabled applications.
 * 
 * See UIApplication (SimulatorRemoteNotifications) for more details on how to enable mock remote notifications in an application.
 */
@interface ACSimulatorRemoteNotificationsService : NSObject

/** @name Accessing the instance */

/** Shared service
 */
+ (instancetype)sharedService;

/** @name Properties */

/** Remote notifications port
 * @discussion The UDP port of the host running the SimulatorRemoteNotifications-enabled application.
 */
@property (nonatomic, assign) NSInteger remoteNotificationsPort;

/** Remote notificaitons host
 * @discussion The IP address of the host running the SimulatorRemoteNotifications-enabled application.
 */
@property (nonatomic, copy) NSString *remoteNotificationsHost;


/** @name Sending remote notifications */

/** Send a mock remote notification
 * @param payload Payload of the notification. Consult Apple's [Local and Push Notification Programming guide](https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Introduction.html#//apple_ref/doc/uid/TP40008194-CH1-SW1) for details about the notifications payload format.
 */
- (void)send:(NSDictionary*)payload;

@end

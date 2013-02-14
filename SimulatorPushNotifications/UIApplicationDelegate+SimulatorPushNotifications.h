//
//  UIApplicationDelegate+SimulatorPushNotifications.h
//  SimulatorPushNotifications
//
//  Created by Arnaud Coomans on 13/02/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import <UIKit/UIKit.h>

#include <arpa/inet.h>
#include <netinet/in.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>

/* Note on payload length:
 * udp max length is 65,507 bytes
 * apns max length is 256 bytes
 */
#define BUFLEN 512
#define PORT 9930

@interface UIResponder (SimulatorPushNotifications)

- (void)setPushNotificationPort:(int)port;
- (int)pushNotificationPort;

- (void)applicationStartListeningForPushNotifications:(UIApplication*)application;

@end

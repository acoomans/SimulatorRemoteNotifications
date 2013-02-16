//
//  UIApplication+SimulatorRemoteNotification.h
//  SimulatorRemoteNotification
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

@interface UIApplication (SimulatorRemoteNotification)

- (void)setRemoteNotificationPort:(int)port;
- (int)remoteNotificationPort;

- (void)listenForRemoteNotification;

@end

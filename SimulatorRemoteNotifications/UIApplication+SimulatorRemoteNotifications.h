//
//  UIApplication+SimulatorRemoteNotifications.h
//  SimulatorRemoteNotifications
//
//  Created by Arnaud Coomans on 13/02/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <arpa/inet.h>
#import <netinet/in.h>
#import <stdio.h>
#import <sys/types.h>
#import <sys/socket.h>
#import <unistd.h>
#import <ifaddrs.h>

/* Note on payload length:
 * udp max length is 65,507 bytes
 * apns max length is 256 bytes
 */
#define BUFLEN 512
#define PORT 9930

@interface UIApplication (SimulatorRemoteNotifications)

- (void)setRemoteNotificationsPort:(int)port;
- (int)remoteNotificationsPort;

- (void)listenForRemoteNotifications;

- (NSString*)getIPAddress;

@end

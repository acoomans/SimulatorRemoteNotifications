//
//  ACSimulatorRemoteNotificationsService.h
//  SimulatorRemoteNotificationsExample
//
//  Created by Arnaud Coomans on 21/02/14.
//  Copyright (c) 2014 acoomans. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <arpa/inet.h>
#import <netinet/in.h>
#import <stdio.h>
#import <sys/types.h>
#import <sys/socket.h>
#import <unistd.h>
#import <ifaddrs.h>
#include <string.h>

#define BUFLEN 512
#define PORT 9930
#define SRV_IP @"localhost"

@interface ACSimulatorRemoteNotificationsService : NSObject

+ (instancetype)sharedService;

@property (nonatomic, assign) NSInteger remoteNotificationsPort;
@property (nonatomic, copy) NSString *remoteNotificationsHost;

- (void)send:(NSDictionary*)payload;

@end

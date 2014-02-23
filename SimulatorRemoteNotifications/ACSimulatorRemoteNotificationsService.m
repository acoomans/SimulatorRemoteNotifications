//
//  ACSimulatorRemoteNotificationsService.m
//  SimulatorRemoteNotificationsExample
//
//  Created by Arnaud Coomans on 21/02/14.
//  Copyright (c) 2014 acoomans. All rights reserved.
//

#import "ACSimulatorRemoteNotificationsService.h"

#import <arpa/inet.h>
#import <netinet/in.h>
#import <stdio.h>
#import <sys/types.h>
#import <sys/socket.h>
#import <unistd.h>
#import <ifaddrs.h>
#include <string.h>

/* Note on payload length:
 * udp max length is 65,507 bytes
 * apns max length is 256 bytes
 */
static const NSInteger SimulatorRemoteNotificationsServiceBufferLength = 512;
static const NSInteger SimulatorRemoteNotificationsServiceDefaultPort = 9930;
static NSString * const SimulatorRemoteNotificationsServiceDefaultHost = @"127.0.0.1";


@implementation ACSimulatorRemoteNotificationsService

+ (instancetype)sharedService {
    static ACSimulatorRemoteNotificationsService *_sharedSimulatorRemoteNotificationsService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSimulatorRemoteNotificationsService = [[super alloc] init];
        _sharedSimulatorRemoteNotificationsService.remoteNotificationsPort = SimulatorRemoteNotificationsServiceDefaultPort;
        _sharedSimulatorRemoteNotificationsService.remoteNotificationsHost = SimulatorRemoteNotificationsServiceDefaultHost;
    });
    
    return _sharedSimulatorRemoteNotificationsService;
}

- (void)send:(NSDictionary*)payload {
    
    struct sockaddr_in si_other;
    int s;
    char buf[SimulatorRemoteNotificationsServiceBufferLength];
    
    if ((s=socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP))==-1) {
		NSLog(@"ACSimulatorRemoteNotificationsService: socket error");
	}
    
    memset((char *) &si_other, 0, sizeof(si_other));
    si_other.sin_family = AF_INET;
    si_other.sin_port = htons(self.remoteNotificationsPort);
    
    const char *host = [self.remoteNotificationsHost cStringUsingEncoding:NSUTF8StringEncoding];
    if (inet_aton(host, &si_other.sin_addr)==0) {
        NSLog(@"ACSimulatorRemoteNotificationsService: inet_aton error");
    }
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:payload options:NSJSONWritingPrettyPrinted error:&error];
    
    
    // TODO: clean (remove buffer?)
    memset(buf, '\0', SimulatorRemoteNotificationsServiceBufferLength);
    strncpy(buf, [data bytes], MIN(data.length, SimulatorRemoteNotificationsServiceBufferLength));
    
    if (sendto(s, buf, strnlen(buf, SimulatorRemoteNotificationsServiceBufferLength), 0, (struct sockaddr*)&si_other, sizeof(si_other))==-1) {
        NSLog(@"ACSimulatorRemoteNotificationsService: sendto error");
    }

    close(s);
}

@end

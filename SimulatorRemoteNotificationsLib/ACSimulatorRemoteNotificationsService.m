//
//  ACSimulatorRemoteNotificationsService.m
//  SimulatorRemoteNotificationsExample
//
//  Created by Arnaud Coomans on 21/02/14.
//  Copyright (c) 2014 acoomans. All rights reserved.
//

#import "ACSimulatorRemoteNotificationsService.h"

@implementation ACSimulatorRemoteNotificationsService

+ (instancetype)sharedService {
    static ACSimulatorRemoteNotificationsService *_sharedSimulatorRemoteNotificationsService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSimulatorRemoteNotificationsService = [[super alloc] init];
        _sharedSimulatorRemoteNotificationsService.remoteNotificationsPort = PORT;
        _sharedSimulatorRemoteNotificationsService.remoteNotificationsHost = SRV_IP;
    });
    
    return _sharedSimulatorRemoteNotificationsService;
}

- (void)send:(NSDictionary*)payload {
    
    struct sockaddr_in si_other;
    int s;
    char buf[BUFLEN];
    
    if ((s=socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP))==-1) {
		NSLog(@"ACSimulatorRemoteNotificationsService: socket error");
	}
    
    memset((char *) &si_other, 0, sizeof(si_other));
    si_other.sin_family = AF_INET;
    si_other.sin_port = htons(self.remoteNotificationsPort);
    
    if (inet_aton([self.remoteNotificationsHost cStringUsingEncoding:NSUTF8StringEncoding], &si_other.sin_addr)==0) {
        NSLog(@"ACSimulatorRemoteNotificationsService: inet_aton error");
    }
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:payload options:NSJSONWritingPrettyPrinted error:&error];
    strncpy(buf, [data bytes], BUFLEN);
    
    if (sendto(s, buf, BUFLEN, 0, (struct sockaddr*)&si_other, sizeof(si_other))==-1) {
        NSLog(@"ACSimulatorRemoteNotificationsService: sendto error");
    }

    close(s);
}


@end

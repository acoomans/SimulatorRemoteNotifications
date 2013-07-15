//
//  UIApplication+SimulatorRemoteNotifications.m
//  SimulatorRemoteNotifications
//
//  Created by Arnaud Coomans on 13/02/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import "UIApplication+SimulatorRemoteNotifications.h"


static int __port = PORT;

@implementation UIApplication (SimulatorRemoteNotifications)

- (void)listenForRemoteNotifications {
	
	static struct sockaddr_in __si_me, __si_other;
	static int __socket;
	static char __buffer[BUFLEN];
	static dispatch_source_t input_src;
	
	if ((__socket=socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP))==-1) {
		NSLog(@"SimulatorRemoteNotification: socket error");
	}
	
	memset((char *) &__si_me, 0, sizeof(__si_me));
	__si_me.sin_family = AF_INET;
	__si_me.sin_port = htons(__port);
	__si_me.sin_addr.s_addr = htonl(INADDR_ANY);
	
	if (bind(__socket, (struct sockaddr*)&__si_me, sizeof(__si_me))==-1) {
		NSLog(@"SimulatorRemoteNotification: bind error");
	}
	
	input_src = dispatch_source_create(DISPATCH_SOURCE_TYPE_READ, __socket, 0, dispatch_get_main_queue());
	dispatch_source_set_event_handler(input_src,  ^{
		socklen_t slen=sizeof(__si_other);
        ssize_t size = 0;
		if ((size = recvfrom(__socket, __buffer, BUFLEN, 0, (struct sockaddr*)&__si_other, &slen))==-1) {
			NSLog(@"SimulatorRemoteNotification: recvfrom error");
		}
		//NSLog(@"SimulatorRemoteNotification: received from %s:%d data = %s\n\n", inet_ntoa(__si_other.sin_addr), ntohs(__si_other.sin_port), __buffer);
		__buffer[size] = NULL;
		NSString *string = [NSString stringWithUTF8String:__buffer];
        
		//NSLog(@"SimulatorRemoteNotification: received string = %@", string);
		
		NSError *error = nil;
		NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
		if (!dict) {
			NSLog(@"SimulatorRemoteNotification: error = %@", error);
		} else if (![dict isKindOfClass:[NSDictionary class]]) {
			NSLog(@"SimulatorRemoteNotification: message error (not a dictionary)");
		} else {
			if ([self.delegate respondsToSelector:@selector(application:didReceiveRemoteNotification:)]) {
					[self.delegate application:self didReceiveRemoteNotification:dict];
			}
		}
	});
    dispatch_source_set_cancel_handler(input_src,  ^{
		NSLog(@"SimulatorRemoteNotification: socket closed");
		close(__socket);
	});
    dispatch_resume(input_src);
	
	if ([self.delegate respondsToSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)]) {
		NSString *deviceTokenString = [NSString stringWithFormat:@"simulator-remote-notification=%@:%d", [self getIPAddress], self.remoteNotificationsPort];
		[self.delegate application:self didRegisterForRemoteNotificationsWithDeviceToken:[deviceTokenString dataUsingEncoding:NSUTF8StringEncoding]];
	}
	
    NSLog(@"SimulatorRemoteNotification: listening on %@:%d", [self getIPAddress], self.remoteNotificationsPort);
}


#pragma mark - port configuration

- (void)setRemoteNotificationsPort:(int)port {
	__port = port;
}

- (int)remoteNotificationsPort {
	return __port;
}

#pragma mark - ip address

- (NSString *)getIPAddress {
	
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
	
	NSString *result = nil;
	
    // retrieve the current interfaces - returns 0 on success
    if (!getifaddrs(&interfaces)) {
		
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            sa_family_t sa_type = temp_addr->ifa_addr->sa_family;
            if(sa_type == AF_INET || sa_type == AF_INET6) {
                NSString *addr = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                //NSString *name = [NSString stringWithUTF8String:temp_addr->ifa_name];
				//NSLog(@"Interface \"%@\" addr %@", name, addr);
				
				if (!result ||
					[result isEqualToString:@"0.0.0.0"] ||
					([result isEqualToString:@"127.0.0.1"] && ![addr isEqualToString:@"0.0.0.0"])
					) {
					result = addr;
				}
					
            }
            temp_addr = temp_addr->ifa_next;
        }
        freeifaddrs(interfaces);
    }
    return result ? result : @"0.0.0.0";
}

@end

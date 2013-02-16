//
//  UIApplication+SimulatorRemoteNotification.m
//  SimulatorRemoteNotification
//
//  Created by Arnaud Coomans on 13/02/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import "UIApplication+SimulatorRemoteNotification.h"


static int __port = PORT;


@implementation UIApplication (SimulatorRemoteNotification)

- (void)listenForRemoteNotification {
	
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
		if (recvfrom(__socket, __buffer, BUFLEN, 0, (struct sockaddr*)&__si_other, &slen)==-1) {
			NSLog(@"SimulatorRemoteNotification: recvfrom error");
		}
		//NSLog(@"SimulatorRemoteNotification: received from %s:%d data = %s\n\n", inet_ntoa(si_other.sin_addr), ntohs(si_other.sin_port), buf);
		
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
}


#pragma mark - port configuration

- (void)setRemoteNotificationPort:(int)port {
	__port = port;
}

- (int)remoteNotificationPort {
	return __port;
}

@end

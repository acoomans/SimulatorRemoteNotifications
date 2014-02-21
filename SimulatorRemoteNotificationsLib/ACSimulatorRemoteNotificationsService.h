//
//  ACSimulatorRemoteNotificationsService.h
//  SimulatorRemoteNotificationsExample
//
//  Created by Arnaud Coomans on 21/02/14.
//  Copyright (c) 2014 acoomans. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ACSimulatorRemoteNotificationsService : NSObject

+ (instancetype)sharedService;

@property (nonatomic, assign) NSInteger remoteNotificationsPort;
@property (nonatomic, copy) NSString *remoteNotificationsHost;

- (void)send:(NSDictionary*)payload;

@end

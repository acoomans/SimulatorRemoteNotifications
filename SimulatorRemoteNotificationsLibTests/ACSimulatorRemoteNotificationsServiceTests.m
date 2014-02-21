//
//  ACSimulatorRemoteNotificationsServiceTests.m
//  SimulatorRemoteNotificationsExample
//
//  Created by Arnaud Coomans on 21/02/14.
//  Copyright (c) 2014 acoomans. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ACSimulatorRemoteNotificationsService.h"


@interface ACSimulatorRemoteNotificationsServiceTests : XCTestCase
@end

@implementation ACSimulatorRemoteNotificationsServiceTests

- (void) testSend {
    [[ACSimulatorRemoteNotificationsService sharedService] send:@{
                                                  @"message": @"message"
                                                  }];
}

@end

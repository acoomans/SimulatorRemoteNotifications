//
//  SimulatorRemoteNotificationsInjector.c
//  SimulatorRemoteNotifications
//
//  Created by Arnaud Coomans on 22/02/14.
//  Copyright (c) 2014 acoomans. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include <stdio.h>

#import "Simulator.h"
#import "swizzling.h"


// the resulting osax should be copied in ~/Library/ScriptingAdditions/

#define EXPORT __attribute__((visibility("default")))

EXPORT OSErr HandleInitEvent(const AppleEvent* ev, AppleEvent* reply, long refcon) {
    NSLog(@"hello from iOS Simulator");
    
    GuiController *guiController = [NSClassFromString(@"GuiController") sharedInstance];
    NSLog(@"%@", [guiController currentSDK]);
    
    return 1;
}
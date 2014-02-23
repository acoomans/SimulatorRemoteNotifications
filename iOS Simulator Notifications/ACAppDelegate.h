//
//  ACAppDelegate.h
//  iOS Simulator Notifications
//
//  Created by Arnaud Coomans on 22/02/14.
//  Copyright (c) 2014 acoomans. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ACAppDelegate : NSObject <NSApplicationDelegate>

@property (nonatomic, assign) IBOutlet NSWindow *window;
@property (nonatomic, assign) IBOutlet NSTextView *payloadTextView;
@property (nonatomic, assign) IBOutlet NSTextField *errorTextField;

@end

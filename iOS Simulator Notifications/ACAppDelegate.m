//
//  ACAppDelegate.m
//  iOS Simulator Notifications
//
//  Created by Arnaud Coomans on 22/02/14.
//  Copyright (c) 2014 acoomans. All rights reserved.
//

#import "ACAppDelegate.h"

#import "ACSimulatorRemoteNotificationsService.h"


static NSString * const ACAppDelegatePayloadUserDefaultsKey = @"ACAppDelegatePayloadUserDefaultsKey";

@interface ACAppDelegate ()<NSTextViewDelegate>
@property (strong,nonatomic) NSDictionary * payload;
@end

@implementation ACAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSDictionary *payload = [[NSUserDefaults standardUserDefaults] objectForKey:ACAppDelegatePayloadUserDefaultsKey];
    
    if (![payload isKindOfClass:NSDictionary.class]) {
        [self resetAction:self];
    } else {
        NSData *data = [NSJSONSerialization dataWithJSONObject:payload options:NSJSONWritingPrettyPrinted error:nil];
        if (data) {
            self.payloadTextView.string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }
    }
    
    _payloadTextView.delegate = self;
    _payloadTextView.richText = NO;
}

#pragma mark - NSTextDelegate

- (void)textDidChange:(NSNotification *)notification
{
    [self updateUI];
}

- (void) updateUI
{
    NSError *error;
    
    NSData *data = [self.payloadTextView.string dataUsingEncoding:NSUTF8StringEncoding];
    _payload = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (!_payload || ![_payload isKindOfClass:NSDictionary.class]) {
        if(error){
            self.errorTextField.stringValue = [NSString stringWithFormat:@"Invalid JSON : %@", error.localizedDescription];
        }else{
            self.errorTextField.stringValue = @"Invalid JSON : Not a dictionnary";
        }
        self.errorTextField.hidden = NO;
    }else{
        self.errorTextField.hidden = YES;
    }
}

#pragma mark - Actions

- (IBAction)resetAction:(id)sender {
    
    NSDictionary *dict = @{
                           @"aps" : @{
                                   @"alert" : @"You got your emails.",
                                   @"badge" : @9,
                                   @"sound" : @"bingbong.aiff"
                                   },
                           @"acme1" : @"bar",
                           @"acme2" : @42
                           };
    
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    self.payloadTextView.string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self updateUI];
}

- (IBAction)sendAction:(id)sender
{
    if(!self.errorTextField.isHidden) return;
    
    [[ACSimulatorRemoteNotificationsService sharedService] send:_payload];
    [[NSUserDefaults standardUserDefaults] setObject:_payload forKey:ACAppDelegatePayloadUserDefaultsKey];
}

@end

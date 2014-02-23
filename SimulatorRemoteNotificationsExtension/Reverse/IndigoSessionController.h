//
//  IndigoSessionController.h
//  SimulatorRemoteNotifications
//
//  Created by Arnaud Coomans on 23/02/14.
//  Copyright (c) 2014 acoomans. All rights reserved.
//

@class BootstrapController;
@class GuiController;

typedef void (^CDUnknownBlockType)(void);


@interface IndigoSessionController : NSObject

+ (id)indigoSessionControllerForGuiController:(id)arg1;

@property unsigned int brokerPort; // @synthesize brokerPort=_brokerPort;
@property(retain) NSMutableDictionary *machServices; // @synthesize machServices=_machServices;
@property NSObject<OS_dispatch_queue> *machServicesQueue; // @synthesize machServicesQueue=_machServicesQueue;
@property BOOL usingInterfaceBuilder; // @synthesize usingInterfaceBuilder=_usingInterfaceBuilder;
@property BOOL usingDashcodeFullScreen; // @synthesize usingDashcodeFullScreen=_usingDashcodeFullScreen;
@property BOOL usingDashcode; // @synthesize usingDashcode=_usingDashcode;
@property int grandchildPid; // @synthesize grandchildPid=_grandchildPid;
@property(copy) NSString *sessionApplicationIdentifier; // @synthesize sessionApplicationIdentifier=_sessionApplicationIdentifier;
@property(copy) NSString *sessionOwner; // @synthesize sessionOwner=_sessionOwner;
@property(copy) NSString *sessionUUID; // @synthesize sessionUUID=_sessionUUID;
@property BOOL sessionLive; // @synthesize sessionLive=_sessionLive;
@property GuiController *guiController; // @synthesize guiController=_guiController;
@property NSObject<OS_dispatch_queue> *sessionQueue; // @synthesize sessionQueue=_sessionQueue;
@property(retain) BootstrapController *bootstrapController; // @synthesize bootstrapController=_bootstrapController;

- (void)registerPort:(unsigned int)arg1 service:(id)arg2 errorHandler:(CDUnknownBlockType)arg3;
- (id)_typeForInstalledApplication:(id)arg1;
- (BOOL)_isUserApplicationInstalled:(id)arg1;
- (void)_uninstallApplication:(id)arg1;
- (BOOL)_installApplication:(id)arg1 withPath:(id)arg2;
- (void)_postLaunchedMessageWithUserInfo:(id)arg1;
- (void)postNotificationName:(id)arg1 userInfo:(id)arg2 reason:(id)arg3;
- (void)watchGrandchildProcess;
- (id)_setConfigurationSDK:(id)arg1 device:(id)arg2;
- (void)setConfigurationSDK:(id)arg1 device:(id)arg2 errorHandler:(CDUnknownBlockType)arg3;
- (void)delayedKill:(id)arg1;
- (void)simulateLocation:(id)arg1;
- (void)requestCloudSync:(id)arg1;
- (void)backgroundAllApps:(id)arg1;
- (void)sendApplicationEvent:(id)arg1;
- (void)endSession:(id)arg1;
- (void)startSession:(id)arg1;
- (void)resetContentAndSettings;
- (void)_launch;
- (void)launch;
- (void)_terminateBecause:(id)arg1;
- (void)terminateBecause:(id)arg1;
- (void)_issueOperationResult:(id)arg1 result:(int)arg2;
- (void)sendReady;
- (void)dealloc;
- (id)initForGuiController:(id)arg1;

@end
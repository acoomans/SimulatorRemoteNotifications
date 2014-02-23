//
//  BootstrapController.h
//  SimulatorRemoteNotifications
//
//  Created by Arnaud Coomans on 23/02/14.
//  Copyright (c) 2014 acoomans. All rights reserved.
//

@protocol SimulatorBridge;
@class NSDistantObject;
@class ISHDeviceInfo;
@class ISHSDKInfo;

typedef void (^CDUnknownBlockType)(void);


@interface BootstrapController : NSObject

+ (id)bootstrapControllerForSDK:(id)arg1 device:(id)arg2;

@property(nonatomic) unsigned int springBoardPort; // @synthesize springBoardPort=_springBoardPort;
@property(nonatomic) unsigned int workspacePort; // @synthesize workspacePort=_workspacePort;
@property(nonatomic) unsigned int systemAppPort; // @synthesize systemAppPort=_systemAppPort;
@property unsigned int bootstrapSubsetPort; // @synthesize bootstrapSubsetPort=_bootstrapSubsetPort;
@property NSObject<OS_dispatch_source> *bootstrapSubsetBrokerSource; // @synthesize bootstrapSubsetBrokerSource=_bootstrapSubsetBrokerSource;
@property unsigned int bootstrapOwnerPort; // @synthesize bootstrapOwnerPort=_bootstrapOwnerPort;
@property BOOL launchdJobsLoaded; // @synthesize launchdJobsLoaded=_launchdJobsLoaded;
@property BOOL bootstrapRunning; // @synthesize bootstrapRunning=_bootstrapRunning;
@property NSObject<OS_dispatch_queue> *bootstrapQueue; // @synthesize bootstrapQueue=_bootstrapQueue;
@property unsigned int hostSupportPort; // @synthesize hostSupportPort=_hostSupportPort;
@property(retain, nonatomic) NSDistantObject<SimulatorBridge> *bridgeDistantObject; // @synthesize bridgeDistantObject=_bridgeDistantObject;
@property NSObject<OS_dispatch_queue> *bridgeQueue; // @synthesize bridgeQueue=_bridgeQueue;
@property(retain) NSMutableDictionary *machServices; // @synthesize machServices=_machServices;
@property NSObject<OS_dispatch_queue> *machServicesQueue; // @synthesize machServicesQueue=_machServicesQueue;
@property(copy) NSString *bootstrapName; // @synthesize bootstrapName=_bootstrapName;
@property(copy, nonatomic) NSString *applicationSupportDirectory; // @synthesize applicationSupportDirectory=_applicationSupportDirectory;
@property(retain) ISHDeviceInfo *device; // @synthesize device=_device;
@property(retain) ISHSDKInfo *sdk; // @synthesize sdk=_sdk;

- (unsigned int)frontmostAppPort;
- (unsigned int)_lookupService:(id)arg1;
- (unsigned int)lookupService:(id)arg1;
- (void)registerPortsWithLaunchd;
- (void)registerService:(id)arg1 asService:(id)arg2 withReply:(CDUnknownBlockType)arg3 onQueue:(id)arg4;
- (void)registerPort:(unsigned int)arg1 asService:(id)arg2 withReply:(CDUnknownBlockType)arg3 onQueue:(id)arg4;
- (void)clearTempPaths;
- (void)ensureHomeSkel;
- (void)updateSimulatorKeymap:(id)arg1;
- (void)terminate;
- (void)launch:(CDUnknownBlockType)arg1;
- (void)brokerBootstrapSubsetOnPort:(unsigned int)arg1;
- (unsigned int)bootstrap;
- (void)destroyBootstrap;
- (void)bootstrapSimulatorSession;
- (id)getLaunchDaemonsPaths;
- (void)createBootstrap;
- (void)unloadLaunchdJobs;
- (void)fixPermissionsForLaunchdPlist:(id)arg1;
- (void)loadLaunchdJobsLegacy;
- (void)loadLaunchdJobs;
- (id)createEnvironment;
- (id)capabilitiesPlistForCurrentDevice;
- (void)cleanupDispatchMemoryFile;
- (void)sendDispatchMemoryWarning;
- (id)memoryWarningFilePath;
- (void)launchApplicationAsync:(id)arg1 arguments:(id)arg2 environment:(id)arg3 standardOutPath:(id)arg4 standardErrorPath:(id)arg5 options:(id)arg6 reply:(CDUnknownBlockType)arg7 queue:(id)arg8 timeout:(double)arg9;
- (void)simulatorBridgeSync:(CDUnknownBlockType)arg1;
- (void)simulatorBridgeAsync:(CDUnknownBlockType)arg1;
- (void)simulatorBridgeCommon:(CDUnknownBlockType)arg1;
- (id)simulatedHomeDirectory;
- (id)logDirectory;
- (id)simulatedHomeDirectoryVersioned:(BOOL)arg1;
- (id)versionedSubdirectory;
- (id)simulatorRuntimeDirectory;
- (void)clearMobileInstallationCache;
- (void)copyGlobalPreferencesPlist;
- (void)installSampleContentIfNecessary;
- (void)dealloc;
- (id)init;

@end
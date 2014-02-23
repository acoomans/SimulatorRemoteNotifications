//
//  swizzling.h
//  SimulatorRemoteNotifications
//
//  Created by Arnaud Coomans on 23/02/14.
//  Copyright (c) 2014 acoomans. All rights reserved.
//

void __attribute__((weak)) MethodSwizzle(Class c, SEL origSEL, SEL overrideSEL, IMP overrideIMP);

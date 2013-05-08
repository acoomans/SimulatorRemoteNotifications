# SimulatorRemoteNotifications

SimulatorRemoteNotifications is an iOS library to send (fake) remote notifications to the iOS simulator.

The library extends _UIApplication_ by embedding a mini server that listen for udp packets containing JSON-formated payload.

Note that SimulatorRemoteNotifications does not send notification through Apple's Push Service.


## Usage

In your iOS project:

1. Add the _SimulatorRemoteNotifications_ directory into your project.
2. Add `#import "UIApplication+SimulatorRemoteNotifications.h"` to your application delegate.
3. Add `[application listenForRemoteNotifications];` to _application:didFinishLaunchingWithOptions:_

Optional: you can set the port by calling _setRemoteNotificationsPort:_

The default port number is 9930

To send a remote notification, send an udp packet to localhost:9930.
You can do this from the terminal by using netcat:

	echo -n '{"message":"message"}' | nc -4u -w1 localhost 9930
	
## Example

You can look at _SimulatorRemoteNotificationsExample.xcodeproj_ and run the example project.
	
## Note

(Real) Apple remote notifications are limited to 256 bytes content length.
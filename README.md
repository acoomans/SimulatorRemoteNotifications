# SimulatorRemoteNotification

This library let you fake push notifications on the iOS simulator.

## Usage

In your iOS project:

1. Add the _SimulatorRemoteNotification_ directory into your project.
2. Add `#import "UIApplication+SimulatorRemoteNotification.h"` to your application delegate.
3. Add `[application listenForRemoteNotification];` to _application:didFinishLaunchingWithOptions:_

Optional: you can set the port by calling _setRemoteNotificationPort:_

The default port number is 9930

To send a fake push notification, send an udp packet to localhost:9930.
You can do this from the terminal by using netcat:

	echo -n '{"message":"message"}' | nc -4u -w1 localhost 9930
	
## Note

Apple push messages are limited to 256 bytes content length.
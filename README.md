# SimulatorRemoteNotifications

SimulatorRemoteNotifications is an iOS library to send (fake) remote notifications to the iOS simulator.

The library extends _UIApplication_ by embedding a mini server that listen for udp packets containing JSON-formated payload.

Note that SimulatorRemoteNotifications does not send notification through Apple's Push Service.


## Usage

In your iOS project:

1. Add the _SimulatorRemoteNotifications_ directory into your project.
2. Add `#import "UIApplication+SimulatorRemoteNotifications.h"` to your application delegate.
3. Add `[application listenForRemoteNotifications];` to _application:didFinishLaunchingWithOptions:_
4. Implement either _application:didReceiveRemoteNotification:_ or _application:didReceiveRemoteNotification:fetchCompletionHandler:_ (background notification, iOS7)


When called, _application:didRegisterForRemoteNotificationsWithDeviceToken:_ receives a token in the following format instead of random characters:
	
	simulator-remote-notification=IP:PORT


The default port number is 9930. If you want to change the port, use:

	[application setRemoteNotificationsPort:1234];


To send a remote notification, send an udp packet to localhost:9930.
You can do this from the terminal by using netcat:

	echo -n '{"message":"message"}' | nc -4u -w1 localhost 9930

Note that if you send a notification while the app is in the background, _application:didReceiveRemoteNotification:fetchCompletionHandler:_ will only be called when you bring the app to the foreground.

	
## Examples

You can look at _SimulatorRemoteNotificationsExample.xcodeproj_ for examples. It contains two targets, where:

- _SimulatorRemoteNotificationsExample_, application:didReceiveRemoteNotification: is called
- _SimulatorRemoteNotificationsBackgroundExample_, application:didReceiveRemoteNotification:fetchCompletionHandler: is called

	
## Note

(Real) Apple remote notifications are limited to 256 bytes content length.
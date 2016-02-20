//
//  ExtensionDelegate.m
//  WatchApp Extension
//
//  Created by Francesco Ingrassia on 24/10/15.
//  Copyright © 2015 Guida alla programmazione su watchOS 2. All rights reserved.
//

#import "ExtensionDelegate.h"
#import "Place.h"

@implementation ExtensionDelegate

- (void)applicationDidFinishLaunching {
    // Perform any final initialization of your application.
}

- (void)applicationDidBecomeActive {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillResignActive {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, etc.
}

-(void)handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)remoteNotification {

	NSDictionary* aps = remoteNotification[@"aps"];
	NSDictionary* alert = aps[@"alert"];
	NSString* title = alert[@"title"];
	if(title){
		Place* place = [Place new];
		place.name = title;
		[[WKExtension sharedExtension].rootInterfaceController presentControllerWithName:@"WeatherInterfaceController" context:place];
	}


}

@end

//
//  NotificationController.m
//  WatchMeteo
//
//  Created by Francesco Ingrassia on 07/12/15.
//  Copyright © 2015 Guida alla programmazione su watchOS 2. All rights reserved.
//

#import "NotificationController.h"

@interface NotificationController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *lblTitle;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *lblMessage;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage *imgBody;

@end

@implementation NotificationController

- (instancetype)init {
    self = [super init];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
        
    }
    return self;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}


- (void)didReceiveLocalNotification:(UILocalNotification *)localNotification withCompletion:(void (^)(WKUserNotificationInterfaceType))completionHandler {
    // This method is called when a local notification needs to be presented.
    // Implement it if you use a dynamic notification interface.
    // Populate your dynamic notification interface as quickly as possible.
    //
    // After populating your dynamic notification interface call the completion block.
    completionHandler(WKUserNotificationInterfaceTypeCustom);
}



- (void)didReceiveRemoteNotification:(NSDictionary *)remoteNotification withCompletion:(void (^)(WKUserNotificationInterfaceType))completionHandler {
    // This method is called when a remote notification needs to be presented.
    // Implement it if you use a dynamic notification interface.
    // Populate your dynamic notification interface as quickly as possible.
    //
    // After populating your dynamic notification interface call the completion block.
 [_lblTitle setText:remoteNotification[@"aps"][@"alert"][@"title"]];
	[_lblMessage setText:remoteNotification[@"aps"][@"alert"][@"body"]];
	[_imgBody setImageNamed:remoteNotification[@"icon"]];
	completionHandler(WKUserNotificationInterfaceTypeCustom);
}


@end




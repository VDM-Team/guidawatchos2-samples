//
//  InterfaceController.m
//  CM_HF WatchKit Extension
//
//  Created by WhiteTiger "sgama la rete" on 28/02/16.
//  Copyright © 2016 WhiteTiger "sgama la rete". All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
}

- (void)willActivate {
    [super willActivate];
}

- (void)didDeactivate {
    [super didDeactivate];
}

#pragma mark - IBAction Methods

- (IBAction)actionHaptickClick:(id)sender {
    [[WKInterfaceDevice currentDevice] playHaptic:(WKHapticTypeClick)];
}

- (IBAction)actionHaptickSuccess:(id)sender {
    [[WKInterfaceDevice currentDevice] playHaptic:(WKHapticTypeSuccess)];
}

- (IBAction)actionHaptickStop:(id)sender {
    [[WKInterfaceDevice currentDevice] playHaptic:(WKHapticTypeStop)];
}

- (IBAction)actionHaptickRetry:(id)sender {
    [[WKInterfaceDevice currentDevice] playHaptic:(WKHapticTypeRetry)];
}

- (IBAction)actionHaptickNotification:(id)sender {
    [[WKInterfaceDevice currentDevice] playHaptic:(WKHapticTypeNotification)];
}

- (IBAction)actionHaptickFailure:(id)sender {
    [[WKInterfaceDevice currentDevice] playHaptic:(WKHapticTypeFailure)];
}

- (IBAction)actionHaptickStart:(id)sender {
    [[WKInterfaceDevice currentDevice] playHaptic:(WKHapticTypeStart)];
}

- (IBAction)actionHaptickDirectionUP:(id)sender {
    [[WKInterfaceDevice currentDevice] playHaptic:(WKHapticTypeDirectionUp)];
}

- (IBAction)actionHaptickDirectionDown:(id)sender {
    [[WKInterfaceDevice currentDevice] playHaptic:(WKHapticTypeDirectionDown)];
}

@end

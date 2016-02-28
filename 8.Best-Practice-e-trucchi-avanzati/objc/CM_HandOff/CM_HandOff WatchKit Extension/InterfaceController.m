//
//  InterfaceController.m
//  CM_HandOff WatchKit Extension
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

    [self invalidateUserActivity];
}

- (void)willActivate {
    [super willActivate];
    
    [self invalidateUserActivity];
}

- (void)didDeactivate {
    [super didDeactivate];
    
    [self invalidateUserActivity];
}

#pragma mark - IBAction Methods

- (IBAction)actionOption1:(id)sender {
    [self updateUserActivity:@"it.book.handoff-active" userInfo:@{@"option" : @"opzione 1"} webpageURL:nil];
}

- (IBAction)actionOption2:(id)sender {
    [self updateUserActivity:@"it.book.handoff-active" userInfo:@{@"option" : @"opzione 1"} webpageURL:nil];
}

- (IBAction)actionOption3:(id)sender {
    [self updateUserActivity:@"it.book.handoff-active" userInfo:@{@"option" : @"opzione 1"} webpageURL:nil];
}

@end

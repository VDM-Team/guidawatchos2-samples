//
//  InterfaceController.m
//  CM_Movie WatchKit Extension
//
//  Created by WhiteTiger "sgama la rete" on 28/02/16.
//  Copyright © 2016 WhiteTiger "sgama la rete". All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@property (nonatomic, weak) IBOutlet WKInterfaceMovie *btnMovie;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    [self.btnMovie setMovieURL:[[NSBundle mainBundle] URLForResource:@"movie" withExtension:@"m4v"]];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

#pragma mark - IBAction Methods

- (IBAction)actionAutoplay:(id)sender {
    [self presentMediaPlayerControllerWithURL:[[NSBundle mainBundle] URLForResource:@"movie" withExtension:@"m4v"] options:@{ WKMediaPlayerControllerOptionsAutoplayKey : @(YES) } completion:^(BOOL didPlayToEnd, NSTimeInterval endTime, NSError * _Nullable error) {
        // NOP
    }];
}

@end

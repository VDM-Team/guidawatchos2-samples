//
//  InterfaceController.m
//  HelloWorldObj WatchKit Extension
//
//  Created by vdmAuthors on 19/02/16.
//  Copyright © 2016 vdmAuthors. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *lblMessaggio;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)buttonPressed {
    [self.lblMessaggio setText:@"Sono un orologio"];
}
@end




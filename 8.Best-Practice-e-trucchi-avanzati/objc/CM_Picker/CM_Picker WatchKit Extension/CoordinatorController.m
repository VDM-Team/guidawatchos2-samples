//
//  CoordinatorController.m
//  CM_Picker
//
//  Created by WhiteTiger "sgama la rete" on 28/02/16.
//  Copyright © 2016 WhiteTiger "sgama la rete". All rights reserved.
//

#import "CoordinatorController.h"

@interface CoordinatorController ()

@property (nonatomic, weak) IBOutlet WKInterfacePicker *picker;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup *group;

@end

@implementation CoordinatorController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    [self createPickerItems];
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

- (void)createPickerItems {
    NSMutableArray<WKPickerItem *> *pickerItems = [NSMutableArray array];
    NSMutableArray<UIImage *> *images = [NSMutableArray array];
    
    for (int i=0; i<100; i++) {
        [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"circle-%d", i]]];
        WKPickerItem *pickerItem = [WKPickerItem new];
        
        [pickerItem setTitle:[NSString stringWithFormat:@"%d", i]];
        [pickerItems addObject:pickerItem];
    }
    
    UIImage *imageAnimated = [UIImage animatedImageWithImages:images duration:0.0];
    [self.group setBackgroundImage:imageAnimated];
    
    [self.picker setCoordinatedAnimations:@[self.group]];
    [self.picker setItems:pickerItems];
}

@end




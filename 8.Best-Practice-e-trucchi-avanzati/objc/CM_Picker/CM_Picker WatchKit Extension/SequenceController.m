//
//  SequenceController.m
//  CM_Picker
//
//  Created by WhiteTiger "sgama la rete" on 28/02/16.
//  Copyright © 2016 WhiteTiger "sgama la rete". All rights reserved.
//

#import "SequenceController.h"

@interface SequenceController ()

@property (nonatomic, weak) IBOutlet WKInterfacePicker *picker;

@end

@implementation SequenceController

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

- (void)createPickerItems {
    NSMutableArray<WKPickerItem *> *pickerItems = [NSMutableArray array];
    
    for (int i=0; i<29; i++) {
        WKPickerItem *pickerItem = [WKPickerItem new];
        
        [pickerItem setContentImage:[WKImage imageWithImageName:[NSString stringWithFormat:@"frame_%d", i]]];
        [pickerItems addObject:pickerItem];
    }
    
    [self.picker setItems:pickerItems];
}

@end




//
//  StackController.m
//  CM_Picker
//
//  Created by WhiteTiger "sgama la rete" on 28/02/16.
//  Copyright © 2016 WhiteTiger "sgama la rete". All rights reserved.
//

#import "StackController.h"

@interface StackController ()

@property (nonatomic, weak) IBOutlet WKInterfacePicker *picker;

@end

@implementation StackController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    [self createPickerItems];
}

- (void)willActivate {
    [super willActivate];
}

- (void)didDeactivate {
    [super didDeactivate];
}

- (void)createPickerItems {
    NSMutableArray<WKPickerItem *> *pickerItems = [NSMutableArray array];
    
    for (int i=1; i<5; i++) {
        WKPickerItem *pickerItem = [WKPickerItem new];
        
        [pickerItem setContentImage:[WKImage imageWithImageName:[NSString stringWithFormat:@"card_0%d", i]]];
        [pickerItems addObject:pickerItem];
    }
    
    [self.picker setItems:pickerItems];
}

@end




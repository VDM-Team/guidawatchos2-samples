//
//  ListController.m
//  CM_Picker
//
//  Created by WhiteTiger "sgama la rete" on 28/02/16.
//  Copyright © 2016 WhiteTiger "sgama la rete". All rights reserved.
//

#import "ListController.h"

@interface ListController ()

@property (nonatomic, weak) IBOutlet WKInterfacePicker *picker;

@end

@implementation ListController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    [self createPickerItems];
    [self.picker focus];
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
    NSMutableArray<WKPickerItem *> *elemens = [NSMutableArray<WKPickerItem *> array];
    NSArray *itemList = @[
                          @{ @"caption" : @"Caption 1", @"title" : @"UNO"},
                          @{ @"caption" : @"Caption 2", @"title" : @"DUE"},
                          @{ @"caption" : @"Caption 3", @"title" : @"TRE"},
                          @{ @"caption" : @"Caption 4", @"title" : @"QUATTRO"},
                          @{ @"caption" : @"Caption 5", @"title" : @"CINQUE"},
                          @{ @"caption" : @"Caption 6", @"title" : @"SEI"},
                          @{ @"caption" : @"Caption 7", @"title" : @"SETTE"},
                          @{ @"caption" : @"Caption 8", @"title" : @"OTTO"},
                          @{ @"caption" : @"Caption 9", @"title" : @"NOVE"},
                          @{ @"caption" : @"Caption 10", @"title" : @"DIECI"} ];
    
    for (NSDictionary *dict in itemList) {
        WKPickerItem *item = [WKPickerItem new];
        item.caption = dict[@"caption"];
        item.title = dict[@"title"];
        [elemens addObject:item];
    }
    
    [self.picker setItems:elemens];
}

@end




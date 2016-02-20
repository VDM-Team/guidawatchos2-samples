//
//  PlaceRowController.h
//  WatchMeteo
//
//  Created by Francesco Ingrassia on 13/11/15.
//  Copyright © 2015 Guida alla programmazione su watchOS 2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>
#import "Place.h"

@interface PlaceRowController : NSObject
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblPlace;
@end

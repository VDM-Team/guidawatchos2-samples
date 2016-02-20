//
//  Weather.h
//  WatchMeteo
//
//  Created by Francesco Ingrassia on 18/07/15.
//  Copyright (c) 2015 Guida alla programmazione su watchOS 2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Place.h"

@interface Weather : NSObject

@property (nonatomic,strong) NSString* weatherID;
@property (nonatomic,strong) Place* place;
@property (nonatomic,strong) NSString* mainDescription;
@property (nonatomic,strong) NSString* longDescription;
@property (nonatomic,strong) NSString* icon;


@property (nonatomic,strong) NSNumber* temp;
@property (nonatomic,strong) NSNumber* pressure;
@property (nonatomic,strong) NSNumber* humidity;
@property (nonatomic,strong) NSNumber* minTemp;
@property (nonatomic,strong) NSNumber* maxTemp;

@property (nonatomic,strong) NSDate* date;

@end

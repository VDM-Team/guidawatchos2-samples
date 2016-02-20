//
//  Place.h
//  AppleWatchMeteo
//
//  Created by Francesco Ingrassia on 18/07/15.
//  Copyright (c) 2015 Guida alla programmazione su watchOS 2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Place : NSObject

@property(nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSString* placeID;
@property(nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,strong) NSString* country;


-(NSDictionary*)toDictionary;
+(Place*)placeWithDictionary:(NSDictionary*)dictionary;


@end

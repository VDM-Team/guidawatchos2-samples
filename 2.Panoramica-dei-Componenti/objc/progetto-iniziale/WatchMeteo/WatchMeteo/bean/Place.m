//
//  Place.m
//  AppleWatchMeteo
//
//  Created by Francesco Ingrassia on 18/07/15.
//  Copyright (c) 2015 Guida alla programmazione su watchOS 2. All rights reserved.
//

#import "Place.h"

@implementation Place


-(NSDictionary*)toDictionary{
	NSMutableDictionary* dic = [NSMutableDictionary dictionary];
	[dic setValue:_name forKey:@"name"];
	[dic setValue:_placeID forKey:@"placeID"];
	[dic setValue:_country forKey:@"country"];
	[dic setValue:@(_coordinate.latitude) forKey:@"lat"];
	[dic setValue:@(_coordinate.longitude) forKey:@"lon"];
	return dic;
}

+(Place*)placeWithDictionary:(NSDictionary*)dic{
	Place* place = [Place new];
	place.name = dic[@"name"];
	place.placeID = dic[@"placeID"];
	place.country = dic[@"country"];
	double lat = [dic[@"lat"] doubleValue];
	double lon = [dic[@"lon"] doubleValue];
	place.coordinate = CLLocationCoordinate2DMake(lat, lon);
	return place;
}



@end

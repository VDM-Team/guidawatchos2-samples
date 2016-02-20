//
//  DataManager.m
//  AppleWatchMeteo
//
//  Created by Francesco Ingrassia on 18/07/15.
//  Copyright (c) 2015 Guida alla programmazione su watchOS 2. All rights reserved.
//

#import "DataManager.h"
#define UD_PLACES_KEY @"UD_PLACES_KEY"
#import "Place.h"

@implementation DataManager

static DataManager* instance;
NSMutableArray* places;

-(instancetype)init
{
	self = [super init];
	if (self) {
		NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
		[ud synchronize];
		NSArray* placeList = [ud objectForKey:UD_PLACES_KEY];
		places = [NSMutableArray array];
		for(NSDictionary* placeDic in placeList)
			[places addObject:[Place placeWithDictionary:placeDic]];
	}
	
	return self;
}

+(instancetype)sharedInstance{
	static dispatch_once_t onceToken;
	
	dispatch_once(&onceToken, ^{
		instance = [DataManager new];
	});
	
	return instance;
}


-(NSArray*)places{
	return [places copy];
}

-(void)addPlace:(Place*)place{
	[places addObject:place];
	[self savePlaces];
}

-(void)removePlace:(Place*)place{
	[places removeObject:place];
	[self savePlaces];
}

-(void)savePlaces{
	NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
	NSMutableArray* placesList = [NSMutableArray array];
	for(Place* place in places)
		[placesList addObject:[place toDictionary]];
	[ud setObject:placesList forKey:UD_PLACES_KEY];
	[ud synchronize];
}

@end
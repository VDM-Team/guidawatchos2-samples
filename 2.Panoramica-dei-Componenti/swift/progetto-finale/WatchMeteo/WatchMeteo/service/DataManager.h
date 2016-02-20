//
//  DataManager.h
//  AppleWatchMeteo
//
//  Created by Francesco Ingrassia on 18/07/15.
//  Copyright (c) 2015 Guida alla programmazione su watchOS 2. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Place;

@interface DataManager : NSObject

+(instancetype)sharedInstance;

-(NSArray*)places;
-(void)addPlace:(Place*)place;
-(void)removePlace:(Place*)place;



@end

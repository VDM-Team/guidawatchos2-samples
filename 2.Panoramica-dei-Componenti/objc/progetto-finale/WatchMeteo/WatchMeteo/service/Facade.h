//
//  Facade.h
//  AppleWatchMeteo
//
//  Created by Francesco Ingrassia on 18/07/15.
//  Copyright (c) 2015 Guida alla programmazione su watchOS 2. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Weather;
@class Forecast;

@interface Facade : NSObject

+(void)getWeatherForPlace:(NSString*)place completionHandler:(void (^)(Weather *weather, NSError *error))completionHandler;
+(void)getForecastForPlace:(NSString*)place completionHandler:(void (^)(Forecast *forecast, NSError *error))completionHandler;


@end

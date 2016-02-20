//
//  DataParser.h
//  AppleWatchMeteo
//
//  Created by Francesco Ingrassia on 18/07/15.
//  Copyright (c) 2015 Guida alla programmazione su watchOS 2. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Weather;
@class Forecast;

@interface DataParser : NSObject

+(Weather *)getWeatherFromData:(NSData *)data error:(NSError **)error;
+(Forecast *)getForecastFromData:(NSData *)data error:(NSError **)error;

@end

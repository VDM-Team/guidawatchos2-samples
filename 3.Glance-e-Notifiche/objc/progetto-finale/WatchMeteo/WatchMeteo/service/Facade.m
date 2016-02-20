//
//  Facade.m
//  AppleWatchMeteo
//
//  Created by Francesco Ingrassia on 18/07/15.
//  Copyright (c) 2015 Guida alla programmazione su watchOS 2. All rights reserved.
//

#import "Facade.h"
#import "NetworkService.h"
#import "Weather.h"
#import "Forecast.h"
#import "DataParser.h"

@implementation Facade


+(void)getWeatherForPlace:(NSString*)place completionHandler:(void (^)(Weather *weather, NSError *error))completionBlock{
	
	[NetworkService getWeatherForPlace:place completionHandler:^(NSData *data, NSError *error) {
		if(error){
			completionBlock(nil,error);
		}else{
			NSError* parserError = nil;
			Weather* weather = [DataParser getWeatherFromData:data error:&parserError];
			if(parserError){
				completionBlock(nil,parserError);
			}else{
				completionBlock(weather,nil);
			}
		}
	}];
}
+(void)getForecastForPlace:(NSString*)place completionHandler:(void (^)(Forecast *forecast, NSError *error))completionBlock{
	[NetworkService getForecastForPlace:place completionHandler:^(NSData *data, NSError *error) {
		if(error){
			completionBlock(nil,error);
		}else{
			NSError* parserError = nil;
			Forecast* forecast = [DataParser getForecastFromData:data error:&parserError];
			if(parserError){
				completionBlock(nil,parserError);
			}else{
				completionBlock(forecast,nil);
			}
		}
	}];
}


@end

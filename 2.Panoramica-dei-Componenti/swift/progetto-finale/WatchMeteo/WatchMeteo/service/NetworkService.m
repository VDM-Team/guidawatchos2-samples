//
//  NetworkService.m
//  AppleWatchMeteo
//
//  Created by Francesco Ingrassia on 18/07/15.
//  Copyright (c) 2015 Guida alla programmazione su watchOS 2. All rights reserved.
//

#import "NetworkService.h"

#define BASE_URL @"http://api.openweathermap.org/data/2.5"
#define WEATHER_FUNCTION @"weather"
#define FORECAST_FUNCTION @"forecast/daily"

#define BASE_QUERY_STRING @"q=%@&lang=it&units=metric&APPID=%@"
#define APIKEY @"INSERISCI QUI LA TUA API KEY"

@implementation NetworkService

+(NSURLSessionDataTask *)getWeatherForPlace:(NSString *)place completionHandler:(void (^)(NSData *data, NSError *error))responseBlock{
	NSAssert([APIKEY isEqualToString:@"INSERISCI QUI LA TUA API KEY"] == NO, @"per utilizzare l'applicazione devi registrarti su openweathermap.com e recuperare la tua API KEY inserendola nella define alla riga 16");
	NSString* queryString = [NSString stringWithFormat:BASE_QUERY_STRING,place,APIKEY];
	
	NSString* urlString = [NSString stringWithFormat:@"%@/%@?%@",BASE_URL,WEATHER_FUNCTION,queryString];
	urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURL* url = [NSURL URLWithString:urlString];
	NSURLSession* session = [NSURLSession sharedSession];
	NSURLSessionDataTask* task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		dispatch_async(dispatch_get_main_queue(), ^{
			responseBlock(data,error);
		});
	}];
	[task resume];
	return task;
}

+(NSURLSessionDataTask *)getForecastForPlace:(NSString*)place completionHandler:(void (^)(NSData *data, NSError *error))responseBlock{
	NSAssert([APIKEY isEqualToString:@"INSERISCI QUI LA TUA API KEY"] == NO, @"per utilizzare l'applicazione devi registrarti su openweathermap.com e recuperare la tua API KEY inserendola nella define alla riga 16");
	
	NSString* queryString = [NSString stringWithFormat:BASE_QUERY_STRING,place,APIKEY];
	NSString* urlString = [NSString stringWithFormat:@"%@/%@?%@",BASE_URL,FORECAST_FUNCTION,queryString];
	urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURL* url = [NSURL URLWithString:urlString];
	NSURLSession* session = [NSURLSession sharedSession];
	NSURLSessionDataTask* task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		dispatch_async(dispatch_get_main_queue(), ^{
			responseBlock(data,error);
		});
	}];
	[task resume];
	return task;
}






@end

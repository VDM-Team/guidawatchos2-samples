//
//  DataParser.m
//  AppleWatchMeteo
//
//  Created by Francesco Ingrassia on 18/07/15.
//  Copyright (c) 2015 Guida alla programmazione su watchOS 2. All rights reserved.
//

#import "DataParser.h"
#import "Weather.h"
#import "Forecast.h"

@implementation DataParser

+(Weather*)getWeatherFromData:(NSData*)data error:(NSError **)error{
	NSDictionary* root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:error];
	
	if(root == nil || *error != nil)
		return nil;
	
	Weather* weather = [self getWeatherFromDictionary:root];
	Place* place = [Place new];
	NSDictionary* coordDic = root[@"coord"];
	if(coordDic){
		NSNumber* lon = coordDic[@"lon"];
		NSNumber* lat = coordDic[@"lon"];
		place.coordinate = CLLocationCoordinate2DMake([lat doubleValue], [lon doubleValue]);
	}
	
	NSDictionary* sysDic = root[@"sys"];
	if(sysDic != nil){
		place.country = sysDic[@"country"];
	}
	place.name = root[@"name"];
	place.placeID = root[@"id"];
	
	weather.place = place;
	
	return weather;
}

+(Forecast*)getForecastFromData:(NSData*)data error:(NSError **)error{
	NSDictionary* root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:error];
	
	if(root == nil || *error != nil)
		return nil;
	
	Forecast* forecast = [Forecast new];
	
	//handle place
	Place* place = [Place new];
	NSDictionary* cityDic = root[@"city"];
	if(cityDic){
		NSDictionary* coordDic = cityDic[@"coord"];
		if(coordDic){
			NSNumber* lon = coordDic[@"lon"];
			NSNumber* lat = coordDic[@"lon"];
			place.coordinate = CLLocationCoordinate2DMake([lat doubleValue], [lon doubleValue]);
		}
		place.country = cityDic[@"country"];
		place.name = cityDic[@"name"];
		place.placeID = cityDic[@"id"];
	}
	
	NSArray* listArray = root[@"list"];
	NSMutableArray* list = [NSMutableArray array];
	
	for(NSDictionary* itemDic in listArray){
		Weather* weather = [self getWeatherFromDictionary:itemDic];
		weather.place = place;
		[list addObject:weather];
	}
	
	forecast.list = list;
	return forecast;
}


+(Weather*)getWeatherFromDictionary:(NSDictionary*)root{

	Weather* weather = [Weather new];
	NSArray* weatherList = root[@"weather"];
	if([weatherList firstObject] != nil){
		NSDictionary* weatherDic = [weatherList firstObject];
		weather.weatherID = weatherDic[@"id"];
		weather.mainDescription = weatherDic[@"main"];
		weather.longDescription = weatherDic[@"description"];
		weather.icon = weatherDic[@"icon"];
	}
	NSDictionary* mainDic = root[@"main"];
	if(mainDic != nil){
		weather.temp = mainDic[@"temp"];
		weather.pressure = mainDic[@"pressure"];
		weather.humidity = mainDic[@"humidity"];
		weather.minTemp = mainDic[@"temp_min"];
		weather.maxTemp = mainDic[@"temp_max"];
	}
	if(root[@"dt"])
		weather.date = [NSDate dateWithTimeIntervalSince1970:[root[@"dt"] doubleValue]];

	return weather;
}


@end

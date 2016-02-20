//
//  NetworkService.h
//  AppleWatchMeteo
//
//  Created by Francesco Ingrassia on 18/07/15.
//  Copyright (c) 2015 Guida alla programmazione su watchOS 2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkService : NSObject


+(NSURLSessionDataTask *)getWeatherForPlace:(NSString*)place completionHandler:(void (^)(NSData *data, NSError *error))responseBlock;
+(NSURLSessionDataTask *)getForecastForPlace:(NSString*)place completionHandler:(void (^)(NSData *data, NSError *error))completionHandler;


@end

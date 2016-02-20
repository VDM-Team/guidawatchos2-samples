//
//  WeatherViewController.h
//  WatchMeteo
//
//  Created by Francesco Ingrassia on 18/07/15.
//  Copyright (c) 2015 Guida alla programmazione su watchOS 2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"
#import "Weather.h"

@interface WeatherViewController : UIViewController

@property (nonatomic,strong) Weather* weather;
@property (nonatomic,strong) Place* place;

-(void)refresh;

@end

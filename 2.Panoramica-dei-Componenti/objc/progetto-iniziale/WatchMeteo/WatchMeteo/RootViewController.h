//
//  RootViewController.h
//  WatchMeteo
//
//  Created by Francesco Ingrassia on 18/07/15.
//  Copyright (c) 2015 Guida alla programmazione su watchOS 2. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Weather;
@interface RootViewController : UIViewController <UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;

-(void)handleNewPlaceWithWeather:(Weather*)weather;


@end


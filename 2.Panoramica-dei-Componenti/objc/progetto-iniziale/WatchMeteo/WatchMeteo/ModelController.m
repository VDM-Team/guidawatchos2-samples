//
//  ModelController.m
//  WatchMeteo
//
//  Created by Francesco Ingrassia on 18/07/15.
//  Copyright (c) 2015 Guida alla programmazione su watchOS 2. All rights reserved.
//

#import "ModelController.h"
#import "SearchViewController.h"
#import "WeatherViewController.h"
#import "DataManager.h"



@interface ModelController ()

@end

@implementation ModelController

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard {
	// Return the data view controller for the given index.
	NSArray* places = [DataManager sharedInstance].places;
	
	if(index > [places count])
		return nil;
	if (index == [places count]) {
	    return [storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
	}

	// Create a new view controller and pass suitable data.
	WeatherViewController *weatherViewController = [storyboard instantiateViewControllerWithIdentifier:@"WeatherViewController"];
	weatherViewController.place = places[index];
	return weatherViewController;
}

- (NSUInteger)indexOfViewController:(UIViewController *)viewController {
	// Return the index of the given data view controller.
	// For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
	NSArray* places = [DataManager sharedInstance].places;
	
	if([viewController isKindOfClass:[SearchViewController class]])
		return [places count];
	
	return [places indexOfObject:((WeatherViewController*)viewController).place];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end

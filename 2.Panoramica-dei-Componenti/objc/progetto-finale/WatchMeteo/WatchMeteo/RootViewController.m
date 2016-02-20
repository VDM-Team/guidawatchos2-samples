//
//  RootViewController.m
//  WatchMeteo
//
//  Created by Francesco Ingrassia on 18/07/15.
//  Copyright (c) 2015 Guida alla programmazione su watchOS 2. All rights reserved.
//

#import "RootViewController.h"
#import "ModelController.h"
#import "DataManager.h"
#import "Weather.h"
#import "WeatherViewController.h"

@interface RootViewController ()

@property (readonly, strong, nonatomic) ModelController *modelController;
@end

@implementation RootViewController

@synthesize modelController = _modelController;

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	// Configure the page view controller and add it as a child view controller.
	self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
	self.pageViewController.delegate = self;

	UIViewController *startingViewController = [self.modelController viewControllerAtIndex:0 storyboard:self.storyboard];
	NSArray *viewControllers = @[startingViewController];
	[self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

	self.pageViewController.dataSource = self.modelController;

	[self addChildViewController:self.pageViewController];
	[self.view addSubview:self.pageViewController.view];

	// Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
	CGRect pageViewRect = self.view.bounds;
	self.pageViewController.view.frame = pageViewRect;

	[self.pageViewController didMoveToParentViewController:self];

//	// Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
//	self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (ModelController *)modelController {
	// Return the model controller object, creating it if necessary.
	// In more complex implementations, the model controller may be passed to the view controller.
	if (!_modelController) {
	    _modelController = [[ModelController alloc] init];
	}
	return _modelController;
}

-(void)handleNewPlaceWithWeather:(Weather*)weather{
	DataManager* dm = [DataManager sharedInstance];
	[dm addPlace:weather.place];
	WeatherViewController* weatherVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WeatherViewController"];
	weatherVC.weather = weather;
	weatherVC.place = weather.place;
	[_pageViewController setViewControllers:@[weatherVC] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
}

@end

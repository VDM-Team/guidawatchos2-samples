//
//  GlanceController.m
//  WatchMeteo
//
//  Created by Francesco Ingrassia on 05/12/15.
//  Copyright © 2015 Guida alla programmazione su watchOS 2. All rights reserved.
//

#import "GlanceController.h"
#import "DataManager.h"
#import "Place.h"
#import "Facade.h"
#import "Weather.h"


@interface GlanceController ()
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblPlace;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblDate;
@property (weak, nonatomic) IBOutlet WKInterfaceImage *imgBody;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblDescription;
@property (strong, nonatomic) Weather* weather;

@end

@implementation GlanceController

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)awakeWithContext:(id)context {
	[super awakeWithContext:context];
	[_lblDate setHidden:YES];
	NSArray* places = [[DataManager sharedInstance] places];
	if([places count] > 0)
		[self startUpdateWithPlace:[places lastObject]];
	else{
		//handle error
	}
}
-(void)startUpdateWithPlace:(Place*)place{
	[_lblPlace setText:place.name];
	[_lblDescription setText:@"Attendi..."];
	[_imgBody setImageNamed:@"Activity"];
	[_imgBody startAnimatingWithImagesInRange:NSMakeRange(1,15) duration:1.0 repeatCount:0];
	__weak typeof(self) weakSelf = self;
	
	[Facade getWeatherForPlace:place.name completionHandler:^(Weather *weather, NSError *error) {
		if(error){
			[weakSelf.lblDescription setText:@"Servizio al momento non disponibile"];
			[_imgBody setHidden:YES];
		}
		else{
			weakSelf.weather = weather;
			[weakSelf refresh];
		}
	}];
}


-(void)refresh{
	NSDateFormatter* dateFormatter = [NSDateFormatter new];
	dateFormatter.timeStyle = NSDateFormatterNoStyle;
	dateFormatter.dateFormat = @"EEE dd MMM";
	[_lblDate setText:[dateFormatter stringFromDate:_weather.date]];
	[_lblDate setHidden:NO];
	[_lblDescription setText:_weather.longDescription];
	[_imgBody setImageNamed:_weather.icon];
}

@end




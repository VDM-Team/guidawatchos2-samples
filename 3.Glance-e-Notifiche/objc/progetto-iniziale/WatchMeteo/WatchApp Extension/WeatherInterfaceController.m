//
//  WeatherInterfaceController.m
//  WatchMeteo
//
//  Created by Francesco Ingrassia on 01/11/15.
//  Copyright © 2015 Guida alla programmazione su watchOS 2. All rights reserved.
//

#import "WeatherInterfaceController.h"
#import "Place.h"
#import "Facade.h"
#import "Weather.h"
#import "Forecast.h"

@interface WeatherInterfaceController ()
@property (nonatomic,strong) Place* place;
@property (nonatomic,strong) Forecast* forecast;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage *imgWeather;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *lblPlace;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *lblDescription;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage *imgActivity;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfacePicker *pckDate;


@end

@implementation WeatherInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
	self.place = context;
	_lblPlace.text = _place.name;
	[self startUpdate];
}

-(void)startUpdate{
	[_lblPlace sizeToFitWidth];
	[_lblPlace setHorizontalAlignment:WKInterfaceObjectHorizontalAlignmentCenter];
	[_imgWeather setWidth:0];
	[_pckDate setHidden:YES];
	[_lblDescription setText:@"Attendi..."];
	[_imgActivity setHidden:NO];
	[_imgActivity setImageNamed:@"Activity"];
	[_imgActivity startAnimatingWithImagesInRange:NSMakeRange(1,15) duration:1.0 repeatCount:0];
	__weak typeof(self) weakSelf = self;
	[Facade getForecastForPlace:_place.name completionHandler:^(Forecast *forecast, NSError *error) {
		if(error){
			WKAlertAction *closeAction = [WKAlertAction actionWithTitle:@"Chiudi" style:WKAlertActionStyleDefault handler:^{
				[weakSelf popToRootController];
			}];
			[weakSelf presentAlertControllerWithTitle:@"Attenzione" message:@"Servizio al momento non disponibile" preferredStyle:WKAlertControllerStyleAlert actions:@[closeAction]];
		}
		else{
			weakSelf.forecast = forecast;
			
			NSMutableArray* items = [NSMutableArray array];
			NSDateFormatter* dateFormatter = [NSDateFormatter new];
			dateFormatter.timeStyle = NSDateFormatterNoStyle;
			dateFormatter.dateFormat = @"EEE dd MMM";
			for(Weather* weather in forecast.list){
				WKPickerItem* item = [WKPickerItem new];
				item.title = [dateFormatter stringFromDate:weather.date];
				item.accessoryImage = [WKImage imageWithImageName:weather.icon];
				[items addObject:item];
			}
			[weakSelf.pckDate setItems:items];
			[weakSelf.pckDate setHidden:NO];
			[weakSelf refresh];
		}
	}];
}

- (void)willActivate {
    [super willActivate];
}

-(void)refresh{
	Weather* todayWeather = _forecast.list[0];
	_lblDescription.text = todayWeather.longDescription;
	[self animateWithDuration:1.5 animations:^{
		_imgActivity.hidden = YES;
		[_imgWeather setImageNamed:todayWeather.icon];
		[_lblPlace setRelativeWidth:1.0 withAdjustment:-50];
		[_lblPlace setHorizontalAlignment:WKInterfaceObjectHorizontalAlignmentLeft];
		[_imgWeather setWidth:50];
	}];
	
}

- (void)didDeactivate {
    [super didDeactivate];
}

- (IBAction)pckDateValueDidChange:(NSInteger)value {
	Weather* weather = _forecast.list[value];
	_lblDescription.text = weather.longDescription;
	[_imgWeather setImageNamed:weather.icon];
}

- (IBAction)menuitemPressed {
	[self startUpdate];
}

@end

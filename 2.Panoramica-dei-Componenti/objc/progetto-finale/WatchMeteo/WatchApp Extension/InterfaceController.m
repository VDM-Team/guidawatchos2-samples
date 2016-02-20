//
//  InterfaceController.m
//  WatchMeteo
//
//  Created by Francesco Ingrassia on 26/10/15.
//  Copyright © 2015 Guida alla programmazione su watchOS 2. All rights reserved.
//

#import "InterfaceController.h"
#import "Facade.h"
#import "DataManager.h"
#import "Weather.h"
#import "PlaceRowController.h"

@interface InterfaceController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *tblPlaces;

@end

@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
	NSArray* places = [[DataManager sharedInstance] places];
	[_tblPlaces setNumberOfRows:[places count] withRowType:@"PlaceRow"];
	for(int i=0; i<[places count]; i++){
		PlaceRowController* row = [_tblPlaces rowControllerAtIndex:i];
		Place* place = places[i];
		[row.lblPlace setText:place.name];
	}
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)btnSearchPressed {
	__weak typeof(self) weakSelf = self;
	[self presentTextInputControllerWithSuggestions:@[@"Milano",@"Roma",@"Napoli"]
								   allowedInputMode:WKTextInputModePlain
										 completion:^(NSArray * _Nullable results) {
											 if(results && [results count] > 0){
												 NSString* res = results[0];
												 [weakSelf handleSearchForKey:res];
											 }
										 }];
}

-(void)handleSearchForKey:(NSString*)key{
	[Facade getWeatherForPlace:key completionHandler:^(Weather *weather, NSError *error) {
		if(error){
			//show error
		}
		else{
			[[DataManager sharedInstance] addPlace:weather.place];
			NSIndexSet* indexSet = [NSIndexSet indexSetWithIndex:0];
			[_tblPlaces insertRowsAtIndexes:indexSet withRowType:@"PlaceRow"];
			PlaceRowController* row = [_tblPlaces rowControllerAtIndex:0];
			[row.lblPlace setText:weather.place.name];
		}
	}];
}

-(void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex{
	Place* place = [[DataManager sharedInstance] places][rowIndex];
	[self pushControllerWithName:@"WeatherInterfaceController" context:place];
}

@end




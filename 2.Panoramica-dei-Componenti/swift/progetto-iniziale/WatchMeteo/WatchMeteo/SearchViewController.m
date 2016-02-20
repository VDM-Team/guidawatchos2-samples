//
//  SearchViewController.m
//  WatchMeteo
//
//  Created by Francesco Ingrassia on 18/07/15.
//  Copyright (c) 2015 Guida alla programmazione su watchOS 2. All rights reserved.
//

#import "SearchViewController.h"
#import "Facade.h"
#import "Weather.h"
#import "RootViewController.h"
#import "AppDelegate.h"

@interface SearchViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
@property (weak, nonatomic) IBOutlet UITextField *tfPlace;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)btnSearchPressed:(id)sender {
	[self search];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
	[self search];
	return YES;
}


-(void)search{
	NSString* key = _tfPlace.text;
	
	
	[Facade getWeatherForPlace:key completionHandler:^(Weather *weather, NSError *error) {
		if(error){
			//show error
		}
		else{
			[((RootViewController*)((AppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController) handleNewPlaceWithWeather:weather];
			NSLog(@"%@",weather.longDescription);
		}
	}];
}


@end

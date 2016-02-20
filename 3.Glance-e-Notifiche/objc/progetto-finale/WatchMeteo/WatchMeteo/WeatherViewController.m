//
//  WeatherViewController.m
//  WatchMeteo
//
//  Created by Francesco Ingrassia on 18/07/15.
//  Copyright (c) 2015 Guida alla programmazione su watchOS 2. All rights reserved.
//

#import "WeatherViewController.h"
#import "Facade.h"

@interface WeatherViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblTemperature;
@property (weak, nonatomic) IBOutlet UILabel *lblPlace;
@property (weak, nonatomic) IBOutlet UILabel *lblCountry;
@property (weak, nonatomic) IBOutlet UILabel *lblWeatherDescription;

@property (weak, nonatomic) IBOutlet UIImageView *imgIconWeather;
@property (weak, nonatomic) IBOutlet UIImageView *imgBackgroundWeather;


@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[self refresh];
}

-(void)refresh{
	if(self.weather){
		[self handleWeather:_weather];
	}else if (self.place){
		[Facade getWeatherForPlace:_place.name completionHandler:^(Weather *weather, NSError *error) {
			if(error){
				//showError
			}
			else{
				self.weather = weather;
				[self handleWeather:weather];
			}
		}];
	//recupera informazioni a partire dal place
	}
}

-(void)handleWeather:(Weather*)weather{
	_lblCountry.text = weather.place.country;
	_lblTemperature.text = [NSString stringWithFormat:@"%d°",[weather.temp intValue]];
	_lblPlace.text = weather.place.name;
	_lblWeatherDescription.text = weather.longDescription;
	
	_imgBackgroundWeather.image = [UIImage imageNamed:weather.icon];
	_imgIconWeather.image = [UIImage imageNamed:weather.icon];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

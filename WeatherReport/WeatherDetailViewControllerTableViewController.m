//
//  WeatherDetailViewControllerTableViewController.m
//  WeatherReport
//
//  Created by Huang Hongsen on 15/11/22.
//  Copyright © 2015年 cn.daniel. All rights reserved.
//

#import "WeatherDetailViewControllerTableViewController.h"
#import "LocationHelper.h"
@interface WeatherDetailViewControllerTableViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *weatherTitle;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *degreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *precipationLabel;
@property (weak, nonatomic) IBOutlet UILabel *chanceOfRainLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *dewPointLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *visibilityLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunriseLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunsetLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureRangeLabel;
@property (nonatomic, strong) NSDictionary *weather;

@property (nonatomic, strong) NSString *degreeUnit;
@property (nonatomic, strong) NSString *speedUnit;
@property (nonatomic, strong) NSString *distanceUnit;
@end

@implementation WeatherDetailViewControllerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateWeatherData];
}

- (void) updateWeatherData
{
    NSDictionary *currentWeather = self.weather[@"currently"];
    self.weatherTitle.text = [NSString stringWithFormat:@"%@ in %@, %@", currentWeather[@"summary"], self.city, self.state];
    self.degreeLabel.text = self.degreeUnit;
    [self updateDailyWeatherInformation];
    self.precipationLabel.text = [self precipationText];
    self.temperatureLabel.text = [NSString stringWithFormat:@"%@", currentWeather[@"temperature"]];
    self.chanceOfRainLabel.text = [NSString stringWithFormat:@"%g %%", [currentWeather[@"precipProbability"] doubleValue] * 100];
    self.windSpeedLabel.text = [NSString stringWithFormat:@"%@ %@", currentWeather[@"windSpeed"], self.speedUnit];
    self.dewPointLabel.text = [NSString stringWithFormat:@"%@ %@", currentWeather[@"dewPoint"], self.degreeUnit];
    self.humidityLabel.text = [NSString stringWithFormat:@"%g %%", [currentWeather[@"humidity"] doubleValue] * 100];
    self.visibilityLabel.text = [NSString stringWithFormat:@"%@ %@", currentWeather[@"visibility"], self.distanceUnit];
}

- (NSString *) precipationText
{
    NSDictionary *currentWeather = self.weather[@"currently"];
    if ([currentWeather[@"precipIntensity"] doubleValue] == 0) {
        return @"None";
    } else {
        return [NSString stringWithFormat:@"%@", currentWeather[@"precipIntensity"]];
    }
}

- (void) updateDailyWeatherInformation
{
    double lowTemp, highTemp;
    NSDictionary *dailyData = self.weather[@"daily"];
    NSDictionary *weatherForToday = [dailyData[@"data"] firstObject];
    lowTemp = [weatherForToday[@"temperatureMin"] doubleValue];
    highTemp = [weatherForToday[@"temperatureMax"] doubleValue];
    self.temperatureRangeLabel.text = [NSString stringWithFormat:@"L: %g° | H: %g°", lowTemp, highTemp];
    
    NSString *timeZoneName = self.weather[@"timezone"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:timeZoneName];
    
    NSInteger sunrise, sunset;
    sunrise = [weatherForToday[@"sunriseTime"] integerValue];
    sunset = [weatherForToday[@"sunsetTime"] integerValue];
    
    self.sunriseLabel.text = [LocationHelper dateDescriptionForTime:sunrise timeZone:timeZone];
    self.sunsetLabel.text = [LocationHelper dateDescriptionForTime:sunset timeZone:timeZone];;
}

#pragma mark - Setters
- (void) setWeatherData:(NSData *)weatherData
{
    _weatherData = weatherData;
    self.weather = [NSJSONSerialization JSONObjectWithData:weatherData options:0 error:NULL];
}

- (void) setSearchMode:(WeatherSearchMode)searchMode
{
    _searchMode = searchMode;
    if (searchMode == WeatherSearchModeCelius) {
        self.degreeUnit = @"°C";
        self.speedUnit = @"m/s";
        self.distanceUnit = @"km";
    } else {
        self.degreeUnit = @"°F";
        self.speedUnit = @"mph";
        self.distanceUnit = @"mi";
    }
}

- (IBAction)handleMoreAction:(id)sender {
    UIAlertController *moreActionsActionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *moreDetailsAction = [UIAlertAction actionWithTitle:@"More Details" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [moreActionsActionSheet addAction:moreDetailsAction];
    UIAlertAction *showMapAction = [UIAlertAction actionWithTitle:@"View Maps" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [moreActionsActionSheet addAction:showMapAction];
    UIAlertAction *facebookAction = [UIAlertAction actionWithTitle:@"Share With Facebook" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [moreActionsActionSheet addAction:facebookAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [moreActionsActionSheet addAction:cancelAction];
    [self presentViewController:moreActionsActionSheet animated:YES completion:nil];
}

@end

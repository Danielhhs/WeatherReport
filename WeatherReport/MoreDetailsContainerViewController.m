//
//  MoreDetailsContainerViewController.m
//  WeatherReport
//
//  Created by Huang Hongsen on 15/11/23.
//  Copyright © 2015年 cn.daniel. All rights reserved.
//

#import "MoreDetailsContainerViewController.h"
#import "NextSevenDaysCollectionViewController.h"
#import "NextTwentyFourHoursTableViewController.h"
#import "ContainerViewControllerHelper.h"
typedef NS_ENUM(NSInteger, WeatherDetailLevel) {
    WeatherDetailLevelNext24Hours = 0,
    WeatherDetailLevelNext7Days = 1
};
@interface MoreDetailsContainerViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *detailLevelSegment;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic, strong) NextSevenDaysCollectionViewController *sevenDaysForecastViewController;
@property (nonatomic, strong) NextTwentyFourHoursTableViewController *twentyFourHoursForecastViewController;
@end

@implementation MoreDetailsContainerViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.detailLevelSegment.selectedSegmentIndex = WeatherDetailLevelNext24Hours;
    [self selectNext24HoursTab];
}

#pragma mark - Lazy Instantiation
- (NextTwentyFourHoursTableViewController *) twentyFourHoursForecastViewController
{
    if (!_twentyFourHoursForecastViewController) {
        _twentyFourHoursForecastViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NextTwentyFourHoursTableViewController"];
    }
    return _twentyFourHoursForecastViewController;
}

- (NextSevenDaysCollectionViewController *) sevenDaysForecastViewController
{
    if (!_sevenDaysForecastViewController) {
        _sevenDaysForecastViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NextSevenDaysCollectionViewController"];
    }
    return _sevenDaysForecastViewController;
}

#pragma mark - Tab selection
- (IBAction)detailLevelChanged:(id)sender {
    if (self.detailLevelSegment.selectedSegmentIndex == WeatherDetailLevelNext24Hours) {
        [self selectNext24HoursTab];
    } else {
        [self selectNext7DaysTab];
    }
}

- (void) selectNext24HoursTab
{
    self.twentyFourHoursForecastViewController.twentyFourHoursWeatherData = self.weatherData[@"hourly"];
    [ContainerViewControllerHelper removeChildViewController:self.sevenDaysForecastViewController];
    [ContainerViewControllerHelper addChildViewController:self.twentyFourHoursForecastViewController toParentViewController:self inContainerView:self.containerView contentArea:self.containerView.bounds];
}

- (void) selectNext7DaysTab
{
    self.sevenDaysForecastViewController.sevenDaysWeatherData = self.weatherData[@"daily"];
    [ContainerViewControllerHelper removeChildViewController:self.twentyFourHoursForecastViewController];
    [ContainerViewControllerHelper addChildViewController:self.sevenDaysForecastViewController toParentViewController:self inContainerView:self.containerView contentArea:self.containerView.bounds];
}

#pragma mark - Actions
- (IBAction)closeTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

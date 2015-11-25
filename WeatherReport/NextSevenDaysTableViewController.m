//
//  NextSevenDaysTableViewController.m
//  WeatherReport
//
//  Created by Huang Hongsen on 15/11/23.
//  Copyright © 2015年 cn.daniel. All rights reserved.
//

#import "NextSevenDaysTableViewController.h"
#import "NextSevenDaysTableViewCell.h"
#import "WeatherImageHelper.h"
#import "LocationHelper.h"
#import "NumberHelper.h"
@interface NextSevenDaysTableViewController ()
@property (nonatomic, strong) NSArray *detailData;
@end

@implementation NextSevenDaysTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) setSevenDaysWeatherData:(NSDictionary *)sevenDaysWeatherData
{
    _sevenDaysWeatherData = sevenDaysWeatherData;
    self.detailData = sevenDaysWeatherData[@"data"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.detailData count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"7DaysCell"];
    NSDictionary *dailyData = self.detailData[indexPath.row];
    if ([cell isKindOfClass:[NextSevenDaysTableViewCell class]]) {
        NextSevenDaysTableViewCell *weatherCell = (NextSevenDaysTableViewCell *)cell;
        weatherCell.temperatureDescription = [NSString stringWithFormat:@"Min: %@%@ | Max: %@%@",[NumberHelper formattedTemperature: dailyData[@"temperatureMin"]], [LocationHelper temperatureUnit], [NumberHelper formattedTemperature:dailyData[@"temperatureMax"]], [LocationHelper temperatureUnit]];
        weatherCell.weatherIcon = [WeatherImageHelper weatherImageForIconName:dailyData[@"icon"]];
        NSInteger time = [dailyData[@"time"] integerValue];
        weatherCell.dayDescription = [LocationHelper dateDescriptionForTime:time];
    }
    return cell;
}

#pragma mark - Table View Delegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

@end

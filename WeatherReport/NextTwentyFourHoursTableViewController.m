//
//  NextTwentyFourHoursTableViewController.m
//  WeatherReport
//
//  Created by Huang Hongsen on 15/11/23.
//  Copyright © 2015年 cn.daniel. All rights reserved.
//

#import "NextTwentyFourHoursTableViewController.h"
#import "NextTwentyFourHoursTableViewCell.h"
#import "LocationHelper.h"
#import "NumberHelper.h"
#import "WeatherImageHelper.h"
#import "LoadMoreDataTableViewCell.h"
@interface NextTwentyFourHoursTableViewController ()
@property (nonatomic, strong) NSArray *detailData;
@property (nonatomic) NSInteger numberOfRows;
@end

@implementation NextTwentyFourHoursTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.numberOfRows = 24;
}

- (void) setTwentyFourHoursWeatherData:(NSDictionary *)twentyFourHoursWeatherData
{
    _twentyFourHoursWeatherData = twentyFourHoursWeatherData;
    self.detailData = twentyFourHoursWeatherData[@"data"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.numberOfRows < [self.detailData count]) {
        return self.numberOfRows + 1;
    }
    return self.numberOfRows;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.numberOfRows) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"24hoursCell"];
        NSDictionary *hourData = self.detailData[indexPath.row];
        if ([cell isKindOfClass:[NextTwentyFourHoursTableViewCell class]]) {
            NextTwentyFourHoursTableViewCell *weatherCell = (NextTwentyFourHoursTableViewCell *) cell;
            NSInteger time = [hourData[@"time"] integerValue];
            weatherCell.time = [LocationHelper hourDescriptionForTime:time];
            weatherCell.temperature = [NumberHelper formattedTemperature:hourData[@"temperature"]];
            weatherCell.weatherImage = [WeatherImageHelper weatherImageForIconName:hourData[@"icon"]];
        }
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"loadMoreDataCell"];
        return cell;
    }
}

#pragma mark - Table View Delegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[LoadMoreDataTableViewCell class]]) {
        self.numberOfRows += 24;
        if (self.numberOfRows > [self.detailData count]) {
            self.numberOfRows = [self.detailData count];
        }
        [tableView reloadData];
    }
}

#define TABLE_VIEW_HEADER_HEIGHT 50

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, TABLE_VIEW_HEADER_HEIGHT)];
    header.backgroundColor = [UIColor purpleColor];
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    timeLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:20];
    timeLabel.text = @"Time";
    [timeLabel sizeToFit];
    UILabel *summaryLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    summaryLabel.text = @"Summary";
    summaryLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:20];
    [summaryLabel sizeToFit];
    UILabel *temperatureLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    temperatureLabel.text = [NSString stringWithFormat:@"Temp (%@)", [LocationHelper temperatureUnit]];
    temperatureLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:20];
    [temperatureLabel sizeToFit];
    
    CGFloat centerY = TABLE_VIEW_HEADER_HEIGHT / 2.f;
    CGFloat width = tableView.frame.size.width;
    timeLabel.center = CGPointMake(width / 6, centerY);
    summaryLabel.center = CGPointMake(width / 2, centerY);
    temperatureLabel.center = CGPointMake(width * 5 / 6, centerY);
    
    [header addSubview:timeLabel];
    [header addSubview:summaryLabel];
    [header addSubview:temperatureLabel];
    return header;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return TABLE_VIEW_HEADER_HEIGHT;
}
@end

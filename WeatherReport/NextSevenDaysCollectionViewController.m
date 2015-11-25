//
//  NextSevenDaysCollectionViewController.m
//  WeatherReport
//
//  Created by Huang Hongsen on 15/11/25.
//  Copyright © 2015年 cn.daniel. All rights reserved.
//

#import "NextSevenDaysCollectionViewController.h"
#import "NextSevenDaysCollectionViewCell.h"
#import "NumberHelper.h"
#import "LocationHelper.h"
#import "WeatherImageHelper.h"
#import "OBSpringyCollectionViewLayout.h"
@interface NextSevenDaysCollectionViewController ()<UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSArray *detailData;
@end

@implementation NextSevenDaysCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.collectionViewLayout = [[OBSpringyCollectionViewLayout alloc] init];
}

- (void) setSevenDaysWeatherData:(NSDictionary *)sevenDaysWeatherData
{
    _sevenDaysWeatherData = sevenDaysWeatherData;
    self.detailData = sevenDaysWeatherData[@"data"];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.detailData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"7DaysCell" forIndexPath:indexPath];
    
    NSDictionary *dailyData = self.detailData[indexPath.row];
    if ([cell isKindOfClass:[NextSevenDaysCollectionViewCell class]]) {
        NextSevenDaysCollectionViewCell *weatherCell = (NextSevenDaysCollectionViewCell *)cell;
        weatherCell.weatherDescription = [NSString stringWithFormat:@"Min: %@%@ | Max: %@%@",[NumberHelper formattedTemperature: dailyData[@"temperatureMin"]], [LocationHelper temperatureUnit], [NumberHelper formattedTemperature:dailyData[@"temperatureMax"]], [LocationHelper temperatureUnit]];
        weatherCell.weatherImage = [WeatherImageHelper weatherImageForIconName:dailyData[@"icon"]];
        NSInteger time = [dailyData[@"time"] integerValue];
        weatherCell.timeDescription = [LocationHelper dateDescriptionForTime:time];
        weatherCell.backgroundColor = [self colorForCellAtIndex:indexPath.row];
    }
    return cell;
}

- (UIColor *) colorForCellAtIndex:(NSInteger)index
{
    NSInteger base = 115;
    NSInteger max = 230;
    index += 1;
    CGFloat component = (base + (max - base) / (CGFloat)7 * index) / 255.f;
    CGFloat red = index % 3 == 0 ? 0 : component;
    CGFloat green = index % 2 == 0 ? 0 : component;
    CGFloat blue = index % 4 == 0 ? 0 : component;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.f];
}

#pragma mark - UICollectionViewDelegate
- (CGSize) collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.bounds.size.width - 30, 97);
}
@end

//
//  NextSevenDaysCollectionViewCell.m
//  WeatherReport
//
//  Created by Huang Hongsen on 15/11/25.
//  Copyright © 2015年 cn.daniel. All rights reserved.
//

#import "NextSevenDaysCollectionViewCell.h"
@interface NextSevenDaysCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;

@end

@implementation NextSevenDaysCollectionViewCell

- (void) setTimeDescription:(NSString *)timeDescription
{
    _timeDescription = timeDescription;
    self.timeLabel.text = timeDescription;
}

- (void) setWeatherDescription:(NSString *)weatherDescription
{
    _weatherDescription = weatherDescription;
    self.temperatureLabel.text = weatherDescription;
}

- (void) setWeatherImage:(UIImage *)weatherImage
{
    _weatherImage = weatherImage;
    self.weatherIcon.image = weatherImage;
}
@end

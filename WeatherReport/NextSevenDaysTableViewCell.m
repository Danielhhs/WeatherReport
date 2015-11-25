//
//  NextSevenDaysTableViewCell.m
//  WeatherReport
//
//  Created by Huang Hongsen on 15/11/23.
//  Copyright © 2015年 cn.daniel. All rights reserved.
//

#import "NextSevenDaysTableViewCell.h"
@interface NextSevenDaysTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;

@end

@implementation NextSevenDaysTableViewCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setDayDescription:(NSString *)dayDescription
{
    _dayDescription = dayDescription;
    self.dayLabel.text = dayDescription;
}

- (void) setTemperatureDescription:(NSString *)temperatureDescription
{
    _temperatureDescription = temperatureDescription;
    self.temperatureLabel.text = temperatureDescription;
}

- (void) setWeatherIcon:(UIImage *)weatherIcon
{
    _weatherIcon = weatherIcon;
    self.weatherImage.image = weatherIcon;
}

@end

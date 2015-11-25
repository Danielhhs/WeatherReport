//
//  NextTwentyFourHoursTableViewCell.m
//  WeatherReport
//
//  Created by Huang Hongsen on 15/11/23.
//  Copyright © 2015年 cn.daniel. All rights reserved.
//

#import "NextTwentyFourHoursTableViewCell.h"
@interface NextTwentyFourHoursTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

@end

@implementation NextTwentyFourHoursTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setTime:(NSString *)time
{
    _time = time;
    self.timeLabel.text = time;
}

- (void) setWeatherImage:(UIImage *)weatherImage
{
    _weatherImage = weatherImage;
    self.weatherImageView.image = weatherImage;
}

- (void) setTemperature:(NSString *)temperature
{
    _temperature = temperature;
    self.temperatureLabel.text = temperature;
}

@end

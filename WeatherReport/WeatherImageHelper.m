//
//  WeatherImageHelper.m
//  WeatherReport
//
//  Created by Huang Hongsen on 15/11/23.
//  Copyright © 2015年 cn.daniel. All rights reserved.
//

#import "WeatherImageHelper.h"

@implementation WeatherImageHelper

+ (UIImage *) weatherImageForIconName:(NSString *)icon
{
    UIImage *image;
    
    NSString *imageName = [NSString stringWithFormat:@"%@.png", icon];
    imageName = [imageName stringByReplacingOccurrencesOfString:@"-" withString:@"_"];
    image = [UIImage imageNamed:imageName];
    return image;
}

@end

//
//  NumberHelper.m
//  WeatherReport
//
//  Created by Huang Hongsen on 15/11/24.
//  Copyright © 2015年 cn.daniel. All rights reserved.
//

#import "NumberHelper.h"

@implementation NumberHelper

+ (NSString *) formattedTemperature:(NSNumber *)number
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
    numberFormatter.minimumFractionDigits = 0;
    numberFormatter.maximumFractionDigits = 2;
    return [numberFormatter stringFromNumber:number];
}

@end

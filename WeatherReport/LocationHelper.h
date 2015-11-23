//
//  StatesHelper.h
//  WeatherReport
//
//  Created by Huang Hongsen on 15/11/20.
//  Copyright © 2015年 cn.daniel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationHelper : NSObject
+ (NSArray *) states;
+ (NSString *) stateCodeForState:(NSString *) state;
+ (NSString *) dateDescriptionForTime:(NSInteger) time timeZone:(NSTimeZone *)timeZone;
@end

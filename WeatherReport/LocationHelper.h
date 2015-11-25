//
//  StatesHelper.h
//  WeatherReport
//
//  Created by Huang Hongsen on 15/11/20.
//  Copyright © 2015年 cn.daniel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enums.h"
@interface LocationHelper : NSObject
+ (NSArray *) states;
+ (NSString *) stateCodeForState:(NSString *) state;
+ (NSString *) hourDescriptionForTime:(NSInteger) time;
+ (NSString *) dateDescriptionForTime:(NSInteger) time;
+ (void) setTimeZone:(NSTimeZone *)timeZone;
+ (void) setSearchMode:(WeatherSearchMode)searchMode;
+ (NSString *) temperatureUnit;
@end

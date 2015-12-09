//
//  StatesHelper.m
//  WeatherReport
//
//  Created by Huang Hongsen on 15/11/20.
//  Copyright © 2015年 cn.daniel. All rights reserved.
//

#import "LocationHelper.h"

static NSArray *states;
static NSDictionary *statesDictionary;
static NSTimeZone *generalTimeZone;
static WeatherSearchMode searchMode;
@implementation LocationHelper

+ (NSArray *) states
{
    if (states == nil) {
        states = @[@"Alaska", @"Alabama", @"Arkansas", @"Arizona", @"California", @"Calorado", @"Connecticut", @"Delaware", @"Florida", @"Georgia", @"Hawaii", @"Iowa", @"Idaho", @"Illinois", @"Indiana", @"Kansas", @"Kentucky", @"Louisiana", @"Massachusetts", @"Marryland", @"Maine", @"Michigan", @"Minnesota", @"Missouri", @"Mississippi", @"Montana", @"North Carolina", @"North Dakota", @"Nebraska", @"New Hampshire", @"New Jersey", @"New Mexico", @"Nevada", @"New York", @"Ohio", @"Oklahoma", @"Oregon", @"Pennsylvania", @"Rhode Island", @"South Carolina", @"South Dakota", @"Tennessee", @"Texas", @"Utah", @"Virginia", @"Vermont", @"Washington", @"Wisconsin", @"West Virginia", @"Wyoming"];
    }
    return states;
}

+ (NSDictionary *) statesDictionary
{
    if (!statesDictionary) {
        statesDictionary = @{@"Alaska" : @"AK",
                             @"Alabama" : @"AL",
                             @"Arkansas" : @"AR",
                             @"Arizona" : @"AZ",
                             @"California" : @"CA",
                             @"Calorado" : @"CO",
                             @"Connecticut" : @"CT",
                             @"Delaware" : @"DE",
                             @"Florida" : @"FL",
                             @"Georgia" : @"GA",
                             @"Hawaii" : @"HI",
                             @"Iowa" : @"IA",
                             @"Idaho" : @"ID",
                             @"Illinois" : @"IL",
                             @"Indiana" : @"IN",
                             @"Kansas" : @"KS",
                             @"Kentucky" : @"KY",
                             @"Louisiana" : @"LA",
                             @"Massachusetts" : @"MA",
                             @"Marryland" : @"MD",
                             @"Maine" : @"ME",
                             @"Michigan" : @"MI",
                             @"Minnesota" : @"MN",
                             @"Missouri" : @"MO",
                             @"Mississippi" : @"MS",
                             @"Montana" : @"MT",
                             @"North Carolina" : @"NC",
                             @"North Dakota" : @"ND",
                             @"Nebraska" : @"NE",
                             @"New Hampshire" : @"NH",
                             @"New Jersey" : @"NJ",
                             @"New Mexico" : @"NM",
                             @"Nevada" : @"NV",
                             @"New York" : @"NY",
                             @"Ohio" : @"OH",
                             @"Oklahoma" : @"OK",
                             @"Oregon" : @"OR",
                             @"Pennsylvania" : @"PA",
                             @"Rhode Island" : @"RI",
                             @"South Carolina" : @"SC",
                             @"South Dakota" : @"SD",
                             @"Tennessee" : @"TN",
                             @"Texas" : @"TX",
                             @"Utah" : @"UT",
                             @"Virginia" : @"VA",
                             @"Vermont" : @"VT",
                             @"Washington" : @"WA",
                             @"Wisconsin" : @"WI",
                             @"West Virginia" : @"WV",
                             @"Wyoming" : @"WY"};
    }
    return statesDictionary;
}

+ (void) setTimeZone:(NSTimeZone *)timeZone
{
    generalTimeZone = timeZone;
}

+ (NSString *) stateCodeForState:(NSString *) state
{
    return [LocationHelper statesDictionary][state];
}

+ (NSString *) hourDescriptionForTime:(NSInteger) time
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    dateFormatter.timeZone = generalTimeZone;
    return [dateFormatter stringFromDate:date];
}

+ (NSString *) twelfHourDescriptionForTime:(NSInteger)time
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm a";
    dateFormatter.timeZone = generalTimeZone;
    return [dateFormatter stringFromDate:date];
}

+ (NSString *) dateDescriptionForTime:(NSInteger) time
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = generalTimeZone;
    dateFormatter.dateFormat = @"EEEE, dd MMMM";
    
    return [dateFormatter stringFromDate:date];
}

+ (void) setSearchMode:(WeatherSearchMode)newSearchMode
{
    searchMode = newSearchMode;
}

+ (NSString *) temperatureUnit
{
    switch (searchMode) {
        case WeatherSearchModeCelius:
            return @"°C";
        case WeatherSearchModeFahrenheit:
            return @"°F";
        default:
            break;
    }
}

@end

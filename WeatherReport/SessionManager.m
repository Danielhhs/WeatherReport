//
//  ServerAPI.m
//  WeatherReport
//
//  Created by Huang Hongsen on 15/11/20.
//  Copyright © 2015年 cn.daniel. All rights reserved.
//

#import "SessionManager.h"
#import "LocationHelper.h"

@interface SessionManager ()<NSURLSessionDataDelegate>

@end

static SessionManager *sharedInstance;
@implementation SessionManager
#pragma mark - Singleton
+ (SessionManager *) sharedManager
{
    if (!sharedInstance) {
        sharedInstance = [[SessionManager alloc] initInternal];
    }
    return sharedInstance;
}

- (instancetype) init
{
    return nil;
}

- (instancetype) initInternal
{
    return [super init];
}

#pragma mark - Request APIs
- (NSString *) serverURLPath
{
    return @"http://johnjavabeanwebapp.elasticbeanstalk.com/index.php";
}

- (NSData *) searchWeatherForAddress:(NSString *)address
                                city:(NSString *)city
                               state:(NSString *)state
                          searchMode:(WeatherSearchMode)searchMode
                             success:(void (^)(NSData *))success
                             failure:(void (^)(NSString *))failure
{
    NSString *parameters = [NSString stringWithFormat:@"?address=%@&city=%@&state=%@&degree=%@", [self replaceSpaceWithPlusInString:address], [self replaceSpaceWithPlusInString:city], [LocationHelper stateCodeForState:state], [self degreeFormatForSearchMode:searchMode]];
    NSString *request = [[self serverURLPath] stringByAppendingString:parameters];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:request]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (error) {
            if (failure) {
                failure([error description]);
            }
        } else {
            success(data);
        }
    }];
    [task resume];
    return nil;
}

- (NSString *) degreeFormatForSearchMode:(WeatherSearchMode)searchMode
{
    switch (searchMode) {
        case WeatherSearchModeFahrenheit:
            return @"us";
        case WeatherSearchModeCelius:
            return @"si";
    }
}

- (NSString *) replaceSpaceWithPlusInString:(NSString *) string
{
    return [string stringByReplacingOccurrencesOfString:@" " withString:@"+"];
}

@end

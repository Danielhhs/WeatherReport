//
//  ServerAPI.h
//  WeatherReport
//
//  Created by Huang Hongsen on 15/11/20.
//  Copyright © 2015年 cn.daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Enums.h"
@interface SessionManager : NSObject
+ (SessionManager *) sharedManager;
- (NSData *) searchWeatherForAddress:(NSString *)address
                                city:(NSString *)city
                               state:(NSString *)state
                          searchMode:(WeatherSearchMode)searchMode
                             success:(void (^)(NSData *))success
                             failure:(void (^)(NSString *))failure;
@end

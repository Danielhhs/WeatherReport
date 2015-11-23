//
//  WeatherDetailViewControllerTableViewController.h
//  WeatherReport
//
//  Created by Huang Hongsen on 15/11/22.
//  Copyright © 2015年 cn.daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Enums.h"
@interface WeatherDetailViewControllerTableViewController : UITableViewController

@property (nonatomic, strong) NSData *weatherData;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic) WeatherSearchMode searchMode;

@end

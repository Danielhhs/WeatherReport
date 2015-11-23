//
//  ActivityMaskView.m
//  WeatherReport
//
//  Created by Huang Hongsen on 15/11/23.
//  Copyright © 2015年 cn.daniel. All rights reserved.
//

#import "ActivityMaskView.h"

@interface ActivityMaskView ()
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@end

ActivityMaskView *sharedInstance;
@implementation ActivityMaskView

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.618];
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self addSubview:self.activityIndicator];
    }
    return self;
}

+ (void) showActivityIndicatorInViewController:(UIViewController *)viewController
{
    if (!sharedInstance) {
        sharedInstance = [[ActivityMaskView alloc] initWithFrame:CGRectZero];
    }
    sharedInstance.frame = [UIApplication sharedApplication].keyWindow.bounds;
    sharedInstance.activityIndicator.center = CGPointMake(CGRectGetMidX(sharedInstance.frame), CGRectGetMidY(sharedInstance.frame));
    UIViewController *containerViewController = viewController;
    if (viewController.navigationController) {
        containerViewController = viewController.navigationController;
    }
    if (containerViewController.tabBarController) {
        containerViewController = containerViewController.tabBarController;
    }
    [containerViewController.view addSubview:sharedInstance];
    [sharedInstance.activityIndicator startAnimating];
}

+ (void) hideAcitivityIndicator
{
    [sharedInstance removeFromSuperview];
    [sharedInstance.activityIndicator stopAnimating];
}
@end

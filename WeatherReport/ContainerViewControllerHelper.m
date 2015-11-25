//
//  ContainerViewControllerHelper.m
//  WeatherReport
//
//  Created by Huang Hongsen on 15/11/23.
//  Copyright © 2015年 cn.daniel. All rights reserved.
//

#import "ContainerViewControllerHelper.h"

@implementation ContainerViewControllerHelper

+ (void) addChildViewController:(UIViewController *)childViewController toParentViewController:(UIViewController *)parentViewController inContainerView:(UIView *)containerView contentArea:(CGRect)area
{
    [parentViewController addChildViewController:childViewController];
    childViewController.view.frame = area;
    [containerView addSubview:childViewController.view];
    [childViewController didMoveToParentViewController:parentViewController];
}

+ (void) removeChildViewController:(UIViewController *)childViewController
{
    [childViewController willMoveToParentViewController:nil];
    [childViewController.view removeFromSuperview];
    [childViewController removeFromParentViewController];
}
@end

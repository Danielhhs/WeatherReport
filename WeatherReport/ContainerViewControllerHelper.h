//
//  ContainerViewControllerHelper.h
//  WeatherReport
//
//  Created by Huang Hongsen on 15/11/23.
//  Copyright © 2015年 cn.daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContainerViewControllerHelper : NSObject

+ (void) addChildViewController:(UIViewController *)childViewController
         toParentViewController:(UIViewController *)parentViewController
                inContainerView:(UIView *)containerView
                    contentArea:(CGRect)area;

+ (void) removeChildViewController:(UIViewController *)childViewController;
@end

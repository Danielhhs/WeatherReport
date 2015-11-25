//
//  FlipTransitionAnimator.m
//  WeatherReport
//
//  Created by Huang Hongsen on 15/11/23.
//  Copyright © 2015年 cn.daniel. All rights reserved.
//

#import "FlipTransitionAnimator.h"
@interface FlipTransitionAnimator()<UIViewControllerAnimatedTransitioning>
@property (nonatomic) BOOL presenting;
@end

static FlipTransitionAnimator *sharedInstance;
@implementation FlipTransitionAnimator

+ (FlipTransitionAnimator *) generalDelegate
{
    if (!sharedInstance) {
        sharedInstance = [[FlipTransitionAnimator alloc] init];
    }
    return sharedInstance;
}

- (id<UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    sharedInstance.presenting = YES;
    return sharedInstance;
}

- (id<UIViewControllerAnimatedTransitioning>) animationControllerForDismissedController:(UIViewController *)dismissed
{
    sharedInstance.presenting = NO;
    return sharedInstance;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (CGFloat) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.618;
}

- (void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if (self.presenting) {
        [UIView transitionFromView:fromViewController.view toView:toViewController.view duration:[self transitionDuration:transitionContext] options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        [UIView transitionFromView:fromViewController.view toView:toViewController.view duration:[self transitionDuration:transitionContext] options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}
@end

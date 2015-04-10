//
//  MSPushViewControllerFromLeft.m
//  MSNavigationAnimations
//
//  Created by Manuj Singh on 2015-03-26.
//  Copyright (c) 2015 Manuj Singh. All rights reserved.
//

#import "MSPushViewControllerFromLeft.h"

@implementation MSPushViewControllerFromLeft
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [containerView addSubview:toViewController.view];
    
    CGRect finalToFrame = fromViewController.view.frame;
    int width = CGRectGetWidth(finalToFrame);
    toViewController.view.frame = CGRectOffset(finalToFrame, -width, 0);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toViewController.view.frame = finalToFrame;
        fromViewController.view.frame = CGRectOffset(finalToFrame, width/4, 0);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end

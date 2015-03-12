//
//  NavigationTransitionAnimator.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "NavigationTransitionAnimator.h"

static CGFloat const kTotalDuration = 0.5f;

@implementation NavigationTransitionAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return kTotalDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.operation == UINavigationControllerOperationPush) {
        [self presentAnimationWithTransitionContext:transitionContext];
        return;
    }
    [self dismissAnimationWithTransitionContext:transitionContext];
}
- (void)presentAnimationWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    
    
}
- (void)dismissAnimationWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    
    
}
@end

//
//  NavigationTransitionAnimator.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "NavigationTransitionAnimator.h"
#import "MainPictureViewController.h"
#import "DetailPictureViewController.h"
#import "PictureCollectionViewCell+PictureEntity.h"

static CGFloat const kTotalDuration = 0.5f;
static CGFloat const kTotalDurationAlpha = 0.6f;

@implementation NavigationTransitionAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return kTotalDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.operation == UINavigationControllerOperationPush) {
        [self presentAnimationWithTransitionContext:transitionContext];
        
    } else if (self.operation == UINavigationControllerOperationPop) {
        [self dismissAnimationWithTransitionContext:transitionContext];
    }
}
- (void)presentAnimationWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    MainPictureViewController *fromViewController = (MainPictureViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    DetailPictureViewController *toViewController = (DetailPictureViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // Container view, where animations will take place
    UIView *contextView = [transitionContext containerView];
    
    UIView *fromView = fromViewController.view;
    UIView *toView = toViewController.view;

    // Add subviews of contextView
    [contextView addSubview:fromView];
    [contextView addSubview:toView];
    
    // Force to recalculate if we are using Autolayout
    [toView layoutIfNeeded];
    
    // Move toViewController to the right, to replicate the default Navigation animation
    CGPoint toViewCenter = toView.center;
    toViewCenter.x += CGRectGetWidth(fromView.frame);
    toView.center = toViewCenter;
    
    toViewController.userImageView.hidden = YES;
    
    //Reference to the UIImageView we will animate
    NSIndexPath *selectedCellIndexPath = [[fromViewController.collectionView indexPathsForSelectedItems] firstObject];
    toViewController.indexPathFromViewController = [selectedCellIndexPath copy];
    PictureCollectionViewCell *selectedCell = (PictureCollectionViewCell *)[fromViewController.collectionView cellForItemAtIndexPath:selectedCellIndexPath];
    
    // Auxiliar image
    UIImageView *animatedImageView = [[UIImageView alloc] initWithImage:selectedCell.pictureImageView.image];
    selectedCell.pictureImageView.hidden = YES;
    // Change coordinate system to toVC
    animatedImageView.frame = [toView convertRect:selectedCell.pictureImageView.frame fromView:selectedCell];
    animatedImageView.contentMode = UIViewContentModeScaleAspectFill;
    animatedImageView.layer.cornerRadius = selectedCell.pictureImageView.layer.cornerRadius;
    animatedImageView.clipsToBounds = YES;
    [toView addSubview:animatedImageView];
    
    // Animation (Core Animation)
    CABasicAnimation *boundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    boundsAnimation.toValue = [NSValue valueWithCGRect:toViewController.userImageView.bounds];
    
    CABasicAnimation *position = [CABasicAnimation animationWithKeyPath:@"position"];
    CGPoint imageCenter = toViewController.userImageView.center;
    imageCenter.y += 64;
    position.toValue = [NSValue valueWithCGPoint:imageCenter];
    
    CABasicAnimation *cornerAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    cornerAnimation.toValue = @(toViewController.userImageView.layer.cornerRadius);
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.toValue = @(0.6);

    
    // Group
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[boundsAnimation, position, cornerAnimation, alphaAnimation];
    groupAnimation.duration = kTotalDuration;
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.fillMode = kCAFillModeForwards;
    [animatedImageView.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
    
    // Animate movement of the main views
    [UIView animateWithDuration:kTotalDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         toView.center = contextView.center;
                         CGPoint fromViewCenter = fromView.center;
                         fromViewCenter.x -= CGRectGetWidth(fromView.frame) * 0.7;
                         fromView.center = fromViewCenter;
                     } completion:^(BOOL finished) {
                         [animatedImageView.layer removeAllAnimations];
                         [animatedImageView removeFromSuperview];
                         selectedCell.pictureImageView.hidden = NO;
                         toViewController.userImageView.alpha = 0.2f;
                         toViewController.userImageView.hidden = NO;
                         [UIView animateWithDuration:kTotalDurationAlpha
                                          animations:^{
                                              toViewController.userImageView.alpha = 1.0f;
                                          } completion:^(BOOL finished) {
                                              [transitionContext completeTransition:YES];
                                          }];
                     }];
}
- (void)dismissAnimationWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    DetailPictureViewController *fromViewController = (DetailPictureViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    MainPictureViewController *toViewController = (MainPictureViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // Container view, where animations will take place
    UIView *contextView = [transitionContext containerView];
    
    UIView *fromView = fromViewController.view;
    UIView *toView = toViewController.view;
    
    // Add subviews of contextView
    [contextView addSubview:fromView];
    [contextView addSubview:toView];
    
    // Force to recalculate if we are using Autolayout
    [toView layoutIfNeeded];
    
    // Move toView to the right, to replicate the default Navigation animation
    CGPoint toViewCenter = toView.center;
    toViewCenter.x += CGRectGetWidth(fromView.frame);
    toView.center = toViewCenter;
    
    PictureCollectionViewCell *selectedCell = (PictureCollectionViewCell *)[toViewController.collectionView cellForItemAtIndexPath:fromViewController.indexPathFromViewController];
    selectedCell.pictureImageView.hidden = YES;
    
    // Auxiliar image
    UIImageView *animatedImageView = [[UIImageView alloc] initWithImage:fromViewController.userImageView.image];
    fromViewController.userImageView.hidden = YES;
    // Change coordinate system to toVC
    animatedImageView.frame = [toView convertRect:fromViewController.userImageView.frame fromView:fromView];
    animatedImageView.contentMode = UIViewContentModeScaleAspectFill;
    animatedImageView.layer.cornerRadius = fromViewController.userImageView.layer.cornerRadius;
    animatedImageView.clipsToBounds = YES;
    [toView addSubview:animatedImageView];
    
    // Animation (Core Animation)
    CABasicAnimation *boundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    boundsAnimation.toValue = [NSValue valueWithCGRect:selectedCell.pictureImageView.bounds];
    
    CABasicAnimation *position = [CABasicAnimation animationWithKeyPath:@"position"];

    UIGraphicsBeginImageContext(selectedCell.pictureImageView.frame.size);
    [selectedCell.pictureImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *copyImageView = [[UIImageView alloc] initWithImage:viewImage];
    // Change reference system
    copyImageView.frame = [toViewController.view convertRect:copyImageView.frame fromView:selectedCell];
    CGPoint imageCenter = copyImageView.center;
    position.toValue = [NSValue valueWithCGPoint:imageCenter];
    
    CABasicAnimation *cornerAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    cornerAnimation.toValue = @(selectedCell.pictureImageView.layer.cornerRadius);
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.toValue = @(0.6);
    
    
    // Group
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[boundsAnimation, position, cornerAnimation, alphaAnimation];
    groupAnimation.duration = kTotalDuration;
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.fillMode = kCAFillModeForwards;
    [animatedImageView.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
    
    // Animate movement of the main views
    [UIView animateWithDuration:kTotalDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         toView.center = contextView.center;
                         CGPoint fromViewCenter = fromView.center;
                         fromViewCenter.x += CGRectGetWidth(fromView.frame) * 0.7;
                         fromView.center = fromViewCenter;
                     } completion:^(BOOL finished) {
                         [animatedImageView.layer removeAllAnimations];
                         [animatedImageView removeFromSuperview];
                         fromViewController.userImageView.hidden = NO;
                         selectedCell.pictureImageView.alpha = 0.2f;
                         selectedCell.pictureImageView.hidden = NO;
                         [UIView animateWithDuration:kTotalDurationAlpha
                                          animations:^{
                                              selectedCell.pictureImageView.alpha = 1.0f;
                                          } completion:^(BOOL finished) {
                                              [transitionContext completeTransition:YES];
                                          }];
                     }];
}


@end

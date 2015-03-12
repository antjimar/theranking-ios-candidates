//
//  NavigationTransitionAnimator.h
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationTransitionAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) UINavigationControllerOperation operation;

@end

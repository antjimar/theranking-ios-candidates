//
//  MainViewController.h
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AJCoreDataCollectionViewController.h"
@class CoreDataStack;

@interface MainPictureViewController : AJCoreDataCollectionViewController

@property (strong, nonatomic) CoreDataStack *coreDataStack;

- (id)initWithFetchedResultsController:(NSFetchedResultsController *)resultsController
                                layout:(UICollectionViewLayout *)layout
                          andIndicator:(UIActivityIndicatorView *)activityIndicator;

@end

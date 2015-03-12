//
//  AJCoreDataCollectionViewController.h
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 11/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreData;

@interface AJCoreDataCollectionViewController : UICollectionViewController

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

+ (instancetype)coreDataCollectionViewControllerWithFetchedResultsController:(NSFetchedResultsController *)resultsController
                                                                      layout:(UICollectionViewLayout *)layout;

-(id) initWithFetchedResultsController:(NSFetchedResultsController *)resultsController
                                layout:(UICollectionViewLayout *)layout;

@end

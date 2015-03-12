//
//  LoadPictureDetailsInteractor.h
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 12/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "BaseInteractor.h"
@class CoreDataStack;
@class PictureEntity;

@interface LoadPictureDetailsInteractor : BaseInteractor

- (instancetype)initWithCoreDataStack:(CoreDataStack *)coreDataStack;
- (PictureEntity *)loadDetailsAtIndexPath:(NSIndexPath *)indexPath
            withFetchedResultsController:(NSFetchedResultsController *)resultsController;

@end


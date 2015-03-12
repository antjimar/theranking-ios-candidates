//
//  LoadPictureDetailsInteractor.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 12/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "LoadPictureDetailsInteractor.h"
#import "CoreDataStack.h"
#import "PictureEntity+Builder.h"

@implementation LoadPictureDetailsInteractor

@synthesize backgroundManagedObjectContext = _backgroundManagedObjectContext;

- (instancetype)initWithCoreDataStack:(CoreDataStack *)coreDataStack {
    self = [super init];
    if (self) {
        _backgroundManagedObjectContext = coreDataStack.backgroundManagedObjectContext;
    }
    return self;
}
- (PictureEntity *)loadDetailsAtIndexPath:(NSIndexPath *)indexPath
             withFetchedResultsController:(NSFetchedResultsController *)resultsController {
    PictureEntity *detailPicture = (PictureEntity *)[resultsController objectAtIndexPath:indexPath];
    return detailPicture;
}


@end

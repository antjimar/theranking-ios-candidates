//
//  LoadPictureDetailsInteractor.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "LoadPictureDetailsInteractor.h"
#import "PictureEntity+Builder.h"
#import "CoreDataStack.h"

@implementation LoadPictureDetailsInteractor

@synthesize backgroundManagedObjectContext = _backgroundManagedObjectContext;

- (instancetype)initWithCoreDataStack:(CoreDataStack *)coreDataStack {
    self = [super init];
    if (self) {
        _backgroundManagedObjectContext = coreDataStack.backgroundManagedObjectContext;
    }
    return self;
}

- (PictureEntity *)showDetailsForPicture:(PictureEntity *)picture {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:kPictureEntityName];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"%K = %@", @"pictureId", [NSString stringWithFormat:@"%@", picture.pictureId]];
    NSArray *pictures = [self.backgroundManagedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    return [pictures firstObject];
}


@end

//
//  LoadPictureDetailsInteractor.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "LoadPictureDetailsInteractor.h"
#import "PictureEntity.h"
#import "CoreDataStack.h"

static NSString * const kPictureEntityName = @"PictureEntity";
static NSString * const kModelName = @"theranking_ios_candidates";

@implementation LoadPictureDetailsInteractor

@synthesize backgroundManagedObjectContext = _backgroundManagedObjectContext;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _backgroundManagedObjectContext = [[[CoreDataStack alloc] initWithModelName:kModelName] backgroundManagedObjectContext];
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

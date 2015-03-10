//
//  LoadPictureDetailsInteractor.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "LoadPictureDetailsInteractor.h"
#import "PictureEntity.h"

static NSString * const kPictureEntityName = @"PictureEntity";

@implementation LoadPictureDetailsInteractor

- (NSArray *)showDetailsForPicture:(PictureEntity *)picture {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:kPictureEntityName];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"%K = %@", @"pictureId", [NSString stringWithFormat:@"%@", picture.pictureId]];
    NSArray *pictures = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    return [pictures firstObject];
}


@end

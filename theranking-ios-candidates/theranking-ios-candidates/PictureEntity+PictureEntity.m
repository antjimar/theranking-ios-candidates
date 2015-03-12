//
//  PictureEntity+PictureEntity.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 12/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "PictureEntity+PictureEntity.h"
#import "PictureCollectionViewCell.h"

@implementation PictureEntity (PictureEntity)

- (NSString *)pictureEntityCellReuseIdentifier {
    return NSStringFromClass([PictureCollectionViewCell class]);
}

@end

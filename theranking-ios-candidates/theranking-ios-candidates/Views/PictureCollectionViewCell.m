//
//  PictureCollectionViewCell.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "PictureCollectionViewCell.h"

@implementation PictureCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.ratingLabel.clipsToBounds = YES;
    self.ratingLabel.layer.cornerRadius = self.ratingLabel.bounds.size.height / 2.0f;
}

@end

//
//  PictureCollectionViewCell+PictureEntity.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 12/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "PictureCollectionViewCell+PictureEntity.h"
#import "PictureEntity+PictureEntity.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation PictureCollectionViewCell (PictureEntity)

- (void)drawPictureEntity:(PictureEntity *)pictureEntity {
    self.pictureNameLabel.text = pictureEntity.pictureName;
    self.ratingLabel.text = [NSString stringWithFormat:@"%@", pictureEntity.pictureRating];
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:pictureEntity.pictureImgURL]
                             placeholderImage:[UIImage imageNamed:@"500px-logo1"]];
}

@end

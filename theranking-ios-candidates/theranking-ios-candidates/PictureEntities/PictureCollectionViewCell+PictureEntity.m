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

#pragma mark - PictureEntityCellProtocol Methods
- (void)drawPictureEntity:(PictureEntity *)pictureEntity {
    self.pictureNameLabel.text = pictureEntity.pictureName;
    self.ratingLabel.text = [NSString stringWithFormat:@"%@", pictureEntity.pictureRating];
    [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:pictureEntity.pictureImgURL]
                             placeholderImage:[UIImage imageNamed:@"500px-logo1"]];
}
- (void)animateElements {
    [UIView animateWithDuration:0.3f animations:^{
        self.ratingLabel.transform = CGAffineTransformMakeRotation(M_PI_4);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3f animations:^{
            self.ratingLabel.transform = CGAffineTransformIdentity;
        }];
    }];
}

@end

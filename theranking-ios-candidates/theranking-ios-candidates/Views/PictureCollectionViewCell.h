//
//  PictureCollectionViewCell.h
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *pictureNameLabel;

@end

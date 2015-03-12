//
//  PictureEntityFactory.h
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 12/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureEntityProtocol.h"
#import "PictureEntityCellProtocol.h"

@interface PictureEntityFactory : NSObject

+ (UICollectionViewCell<PictureEntityCellProtocol> *)cellForEntity:(id<PictureEntityProtocol>)entity
                                                 forCollectionView:(UICollectionView *)collectionView
                                                       atIndexPath:(NSIndexPath *)indexpath;
+ (void)registerCellsInCollectionView:(UICollectionView *)collectionView;

@end

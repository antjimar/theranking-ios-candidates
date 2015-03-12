//
//  PictureEntityFactory.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 12/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "PictureEntityFactory.h"
#import "PictureEntity+PictureEntity.h"
#import "PictureCollectionViewCell+PictureEntity.h"

@implementation PictureEntityFactory

+ (UICollectionViewCell<PictureEntityCellProtocol> *)cellForEntity:(id<PictureEntityProtocol>)entity
                                                 forCollectionView:(UICollectionView *)collectionView
                                                       atIndexPath:(NSIndexPath *)indexpath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:[entity pictureEntityCellReuseIdentifier]
                                                     forIndexPath:indexpath];
}
+ (void)registerCellsInCollectionView:(UICollectionView *)collectionView {
    [self registerCellsInCollectionView:collectionView withClass:[PictureCollectionViewCell class]];

}
+ (void)registerCellsInCollectionView:(UICollectionView *)collectionView withClass:(Class)class {
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(class)];
    // Add new cells here and #import
}

@end

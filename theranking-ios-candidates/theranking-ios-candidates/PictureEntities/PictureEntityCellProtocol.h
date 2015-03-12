//
//  PictureEntityCellProtocol.h
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 12/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PictureEntityProtocol.h"

@protocol PictureEntityCellProtocol <NSObject>

- (void)drawPictureEntity:(id<PictureEntityProtocol>)pictureEntity;
- (void)animateElements;

@end

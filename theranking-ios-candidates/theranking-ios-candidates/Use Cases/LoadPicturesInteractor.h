//
//  LoadPicturesInteractor.h
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "BaseInteractor.h"
@class PicturesProvider;
@class PictureEntity;

@interface LoadPicturesInteractor : BaseInteractor

@property (strong, nonatomic) PicturesProvider *pictureProvider;

- (void)listOfPicuresWithCompletionBlock:(void(^)(NSArray *pictures))completion;

@end

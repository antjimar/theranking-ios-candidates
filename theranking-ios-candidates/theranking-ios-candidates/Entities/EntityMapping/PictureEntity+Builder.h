//
//  PictureEntity+Parser.h
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "PictureEntity.h"

extern const struct PictureEntityAttributes {
    __unsafe_unretained NSString * pictureRating;
} PictureEntityAttributes;

extern NSString * const kPictureEntityName;

@interface PictureEntity (Builder)

+ (void)pictureFromDictionary:(NSDictionary *)pictureDictionary inPicture:(PictureEntity *)picture;

@end

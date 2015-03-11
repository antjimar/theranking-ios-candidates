//
//  PictureEntity+Parser.h
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "PictureEntity.h"

extern const struct PictureEntityAttributes {
    __unsafe_unretained NSString * pictureId;
    __unsafe_unretained NSString * pictureImgURL;
    __unsafe_unretained NSString * pictureName;
    __unsafe_unretained NSString * pictureRating;
    __unsafe_unretained NSString * pictureDescription;
    __unsafe_unretained NSString * pictureUserFullName;
    __unsafe_unretained NSString * pictureUserAvatarURL;
    __unsafe_unretained NSString * pictureCamera;
    __unsafe_unretained NSString * pictureCameraLens;
    __unsafe_unretained NSString * pictureCameraFocalLength;
    __unsafe_unretained NSString * pictureCameraISO;
    __unsafe_unretained NSString * pictureCameraShutterSpeed;
    __unsafe_unretained NSString * pictureCameraAperture;
    __unsafe_unretained NSString * pictureLatitud;
    __unsafe_unretained NSString * pictureLongitud;
}PictureEntityAttributes;


extern NSString * const kPictureEntityName;

@interface PictureEntity (Builder)

+ (void)pictureFromDictionary:(NSDictionary *)pictureDictionary inPicture:(PictureEntity *)picture;

@end

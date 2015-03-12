//
//  PictureEntity.h
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@interface PictureEntity : NSManagedObject

@property (nonatomic, retain) NSString * pictureId;
@property (nonatomic, retain) NSString * pictureImgURL;
@property (nonatomic, retain) NSString * pictureName;
@property (nonatomic, retain) NSNumber * pictureRating;
@property (nonatomic, retain) NSString * pictureDescription;
@property (nonatomic, retain) NSString * pictureUserFullName;
@property (nonatomic, retain) NSString * pictureUserAvatarURL;
@property (nonatomic, retain) NSString * pictureCamera;
@property (nonatomic, retain) NSString * pictureCameraLens;
@property (nonatomic, retain) NSString * pictureCameraFocalLength;
@property (nonatomic, retain) NSString * pictureCameraISO;
@property (nonatomic, retain) NSString * pictureCameraShutterSpeed;
@property (nonatomic, retain) NSString * pictureCameraAperture;
@property (nonatomic, retain) NSNumber * pictureLatitud;
@property (nonatomic, retain) NSNumber * pictureLongitud;

@end

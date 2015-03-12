//
//  PictureEntity+Parser.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "PictureEntity+Builder.h"

const struct PictureEntityAttributes PictureEntityAttributes = {
    .pictureRating = @"pictureRating",
};

static NSString * const kDotSeparator = @".";
static NSString * const kCameraJSON = @"camera";
static NSString * const kApertureJSON = @"aperture";
static NSString * const kFocalLengthJSON = @"focal_length";
static NSString * const kIsoJSON = @"iso";
static NSString * const kLensJSON = @"lens";
static NSString * const kShutterSpeedJSON = @"shutter_speed";
static NSString * const kDescriptionJSON = @"description";
static NSString * const kIdJSON = @"id";
static NSString * const kImageURLJSON = @"image_url";
static NSString * const kLatitudeJSON = @"latitude";
static NSString * const kLongitudeJSON = @"longitude";
static NSString * const kNameJSON = @"name";
static NSString * const kRatingJSON = @"rating";
static NSString * const kUserPicURLJSON = @"user.userpic_url";
static NSString * const kFullnameJSON = @"user.fullname";
NSString * const kPictureEntityName = @"PictureEntity";

@implementation PictureEntity (Builder)

+ (void)pictureFromDictionary:(NSDictionary *)pictureDictionary inPicture:(PictureEntity *)picture {
    // Provisional parser only for this kind of objects, with this structure
    NSDictionary *picturePropertiesMapper = @{
                                              @"pictureCamera": kCameraJSON,
                                              @"pictureCameraAperture": kApertureJSON,
                                              @"pictureCameraFocalLength": kFocalLengthJSON,
                                              @"pictureCameraISO": kIsoJSON,
                                              @"pictureCameraLens": kLensJSON,
                                              @"pictureCameraShutterSpeed": kShutterSpeedJSON,
                                              @"pictureDescription": kDescriptionJSON,
                                              @"pictureId": kIsoJSON,
                                              @"pictureImgURL": kImageURLJSON,
                                              @"pictureLatitud": kLatitudeJSON,
                                              @"pictureLongitud": kLongitudeJSON,
                                              @"pictureName": kNameJSON,
                                              @"pictureRating": kRatingJSON,
                                              @"pictureUserAvatarURL": kUserPicURLJSON,
                                              @"pictureUserFullName": kFullnameJSON
                                              };
    for (NSString *property in [[picture entity] attributesByName]) {
        NSString *prop = [NSString stringWithFormat:@"%@", property];
        NSString *propMapper = [picturePropertiesMapper valueForKey:prop];
        if ([propMapper containsString:kDotSeparator]) {
            NSArray *splitProperty = [propMapper componentsSeparatedByString:@"."];
            //Improve if the array size > 2
            [picture setValue:[self objectFromDictVal:pictureDictionary[splitProperty[0]][splitProperty[1]]] forKey:prop];
        } else {
            id value;
            if ([prop isEqualToString:@"rating"]) {
                value = @([[self objectFromDictVal:pictureDictionary[propMapper]] floatValue]);
                
            } else if ([prop isEqualToString:@"latitud"] || [prop isEqualToString:@"longitud"]) {
                value = @([[self objectFromDictVal:pictureDictionary[propMapper]] doubleValue]);
                
            } else if ([prop isEqualToString:@"pictureId"]) {
                value = [NSString stringWithFormat:@"%@", pictureDictionary[propMapper]];
                
            } else {
                value = [self objectFromDictVal:pictureDictionary[propMapper]];
            }
            [picture setValue:value forKey:prop];
        }
    }
}

#pragma mark - Utils Methods
+ (id)objectFromDictVal:(id)val {
    id returnVal;
    if([val isEqual:[NSNull null]] || val == nil){
        returnVal = nil;
    } else {
        returnVal = val;
    }
    return returnVal;
}

@end

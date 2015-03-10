//
//  PicturesProvider.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "PicturesProvider.h"
#import "PictureEntity+Builder.h"

NSInteger const kNumberOfPhotos = 60;
NSInteger const kImageSize = 4;
NSString * const kPhotosKey = @"photos";
NSString * const kPictureEntityName = @"PictureEntity";

@implementation PicturesProvider

- (void)loadPicturesWithSuccess:(SuccessBlock)successBlock error:(ErrorBlock)errorBlock {
    // Read from core data
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:kPictureEntityName];
    NSArray *pictures = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    successBlock(pictures);
    
    // Download from API Rest
    NSDictionary* URLParams = @{
                                @"feature": @"popular",
                                @"rpp": [NSString stringWithFormat:@"%li?image_size=%li", (long)kNumberOfPhotos, (long)kImageSize],
                                @"consumer_key": kConsumerKey,
                                };
    [self.requestManager GET:self.requestManager.baseDomain parameters:URLParams completion:^(id data) {
        NSMutableArray *pictures = [NSMutableArray array];
        NSDictionary *picturesDictionary = [PictureEntity dictionaryFromData:data];
        for (NSDictionary *dict in picturesDictionary[kPhotosKey]) {
            NSString *pictureId = [NSString stringWithFormat:@"%@", dict[@"id"]];
            if (![self existPictureInDataBase:pictureId]) {
                PictureEntity *picture = [NSEntityDescription insertNewObjectForEntityForName:kPictureEntityName
                                                                       inManagedObjectContext:self.managedObjectContext];
                [self parseFromDictionary:dict picture:picture];
                [pictures addObject:picture];
            }
        }
        NSError *errorSave;
        [self.managedObjectContext save:&errorSave];
        
    } error:^(id data, NSError *error) {
        errorBlock(nil, error);
    }];
}

#pragma mark - Utils Methods
- (void)parseFromDictionary:(NSDictionary *)dict picture:(PictureEntity *)picture {
    picture.pictureId = [NSString stringWithFormat:@"%@", dict[@"id"]];
    picture.pictureImgURL = [self objectFromDictVal:dict[@"image_url"]];
    picture.pictureName = [self objectFromDictVal:dict[@"name"]];
    picture.pictureRating = @([[self objectFromDictVal:dict[@"rating"]] floatValue]);
    picture.pictureDescription = [self objectFromDictVal:dict[@"description"]];
    picture.pictureUserFullName = [self objectFromDictVal:dict[@"fullname"]];
    picture.pictureUserAvatarURL = [self objectFromDictVal:dict[@"userpic_url"]];
    picture.pictureCamera = [self objectFromDictVal:dict[@"camera"]];
    picture.pictureCameraLens = [self objectFromDictVal:dict[@"lens"]];
    picture.pictureCameraFocalLength = [self objectFromDictVal:dict[@"focal_length"]];
    picture.pictureCameraISO = [self objectFromDictVal:dict[@"iso"]];
    picture.pictureCameraShutterSpeed = [self objectFromDictVal:dict[@"shutter_speed"]];
    picture.pictureCameraAperture = [self objectFromDictVal:dict[@"aperture"]];
    picture.pictureLatitud = @([[self objectFromDictVal:dict[@"latitud"]] doubleValue]);
    picture.pictureLongitud = @([[self objectFromDictVal:dict[@"longitud"]] doubleValue]);
}
- (BOOL)existPictureInDataBase:(NSString *)pictureId {
    BOOL result = NO;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:kPictureEntityName];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"%K = %@", @"pictureId", [NSString stringWithFormat:@"%@", pictureId]];
    NSArray *pictures = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    if (pictures.count > 0) {
        result = YES;
    }
    return result;
}
- (id)objectFromDictVal:(id)val {
    id returnVal;
    if([val isEqual:[NSNull null]] || val == nil){
        returnVal = nil;
    } else {
        returnVal = val;
    }
    return returnVal;
}


@end



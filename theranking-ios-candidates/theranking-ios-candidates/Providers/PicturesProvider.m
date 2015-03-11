//
//  PicturesProvider.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "PicturesProvider.h"
#import "PictureEntity+Builder.h"
#import "CoreDataStack.h"

static NSInteger const kNumberOfPhotos = 60;
static NSInteger const kImageSize = 4;
static NSString * const kPhotosKey = @"photos";
static NSString * const kPictureEntityName = @"PictureEntity";
static NSString * const kModelName = @"theranking_ios_candidates";

@implementation PicturesProvider

@synthesize backgrounManagedObjectContext = _backgrounManagedObjectContext;

- (instancetype)init {
    self = [super init];
    if (self) {
        _backgrounManagedObjectContext = [[[CoreDataStack alloc] initWithModelName:kModelName] backgroundManagedObjectContext];
    }
    return self;
}

- (void)loadPicturesWithSuccess:(SuccessBlock)successBlock error:(ErrorBlock)errorBlock {
    // Download from API Rest
    NSDictionary* URLParams = @{
                                @"feature": @"popular",
                                @"rpp": [NSString stringWithFormat:@"%li?image_size=%li", (long)kNumberOfPhotos, (long)kImageSize],
                                @"consumer_key": kConsumerKey,
                                };
    [self.requestManager GET:self.requestManager.baseDomain parameters:URLParams completion:^(id data) {
        NSMutableArray *pictures = [NSMutableArray array];
        NSDictionary *picturesDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        for (NSDictionary *dict in picturesDictionary[kPhotosKey]) {
            [pictures addObject:dict];
        }
        // Update Data Base (Core Data)
        [self updateDataBaseWithNewPictures:[pictures copy] withCompletion:^(NSArray *pictures) {
            successBlock(pictures);
        }];
        
    } error:^(id data, NSError *error) {
        errorBlock(nil, error);
    }];
}


#pragma mark - Utils Methods
- (void)updateDataBaseWithNewPictures:(NSArray *)newPictures withCompletion:(void(^)(NSArray *pictures))completion {
    // Get last data saved in core data, delete and insert new data from rest service in background
    __weak typeof(self) weakSelf = self;
    [self.backgrounManagedObjectContext performBlock:^{
        __strong typeof(weakSelf) self = weakSelf;
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:kPictureEntityName];
        NSArray *lastPicturesSaved = [self.backgrounManagedObjectContext executeFetchRequest:fetchRequest error:nil];
        for (PictureEntity *lastPicture in lastPicturesSaved) {
            [self.backgrounManagedObjectContext deleteObject:lastPicture];
        }
        
        NSMutableArray *pictures = [[NSMutableArray alloc] init];
        // Save newPictures array
        for (NSDictionary *newPicture in newPictures) {
            PictureEntity *picture = [NSEntityDescription insertNewObjectForEntityForName:kPictureEntityName
                                                                   inManagedObjectContext:self.backgrounManagedObjectContext];
            [PictureEntity pictureFromDictionary:newPicture inPicture:picture];
            [pictures addObject:picture];
        }
        NSError *error = nil;
        [self.backgrounManagedObjectContext save:&error];
        completion([pictures copy]);
    }];
}

@end



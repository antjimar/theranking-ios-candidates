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

static NSInteger const kNumberOfPhotos = 40;
static NSInteger const kImageSize = 4;
static NSString * const kPhotosKey = @"photos";

@implementation PicturesProvider

@synthesize backgroundManagedObjectContext = _backgroundManagedObjectContext;

- (instancetype)initWithBackgroundManagedObjectContext:(NSManagedObjectContext *)backgroundManagedObjectContext {
    self = [super init];
    if (self) {
        _backgroundManagedObjectContext = backgroundManagedObjectContext;
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
    [self.backgroundManagedObjectContext performBlock:^{
        __strong typeof(weakSelf) self = weakSelf;
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:kPictureEntityName];
        NSArray *lastPicturesSaved = [self.backgroundManagedObjectContext executeFetchRequest:fetchRequest error:nil];
        for (PictureEntity *lastPicture in lastPicturesSaved) {
            [self.backgroundManagedObjectContext deleteObject:lastPicture];
        }
        
        NSMutableArray *pictures = [[NSMutableArray alloc] init];
        // Save newPictures array
        for (NSDictionary *newPicture in newPictures) {
            PictureEntity *picture = [NSEntityDescription insertNewObjectForEntityForName:kPictureEntityName
                                                                   inManagedObjectContext:self.backgroundManagedObjectContext];
            [PictureEntity pictureFromDictionary:newPicture inPicture:picture];
            [pictures addObject:picture];
        }
        NSError *error = nil;
        [self.backgroundManagedObjectContext save:&error];
        completion([pictures copy]);
    }];
}

@end



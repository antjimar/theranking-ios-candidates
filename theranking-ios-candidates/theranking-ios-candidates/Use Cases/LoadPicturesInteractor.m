//
//  LoadPicturesInteractor.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "LoadPicturesInteractor.h"
#import "PicturesProvider.h"

@implementation LoadPicturesInteractor

@synthesize backgroundManagedObjectContext = _backgroundManagedObjectContext;

- (instancetype)initWithCoreDataStack:(CoreDataStack *)coreDataStack {
    self = [super init];
    if (self) {
        _backgroundManagedObjectContext = coreDataStack.backgroundManagedObjectContext;
    }
    return self;
}
- (void)listOfPicuresWithCompletionBlock:(void(^)(NSArray *pictures))completion {
    [self.pictureProvider loadPicturesWithSuccess:^(id data) {
        completion(data);
    } error:^(id data, NSError *error) {
        completion(nil);
    }];
}

#pragma mark - Lazy loading Methods
- (PicturesProvider *)pictureProvider {
    if (!_pictureProvider) {
        _pictureProvider = [[PicturesProvider alloc] initWithBackgroundManagedObjectContext:self.backgroundManagedObjectContext];
    }
    return _pictureProvider;
}

@end

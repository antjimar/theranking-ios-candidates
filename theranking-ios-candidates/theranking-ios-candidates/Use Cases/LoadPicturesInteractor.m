//
//  LoadPicturesInteractor.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "LoadPicturesInteractor.h"
#import "PicturesProvider.h"
#import "PicturesProvider.h"

@implementation LoadPicturesInteractor

- (void)listOfPicuresWithCompletionBlock:(void(^)(NSArray *pictures))completion {
    [self.pictureProvider loadPicturesWithSuccess:^(id data) {
        completion(data);
    } error:^(id data, NSError *error) {
        completion(nil);
    }];
}

#pragma mark - Lazy loading Methods
-(PicturesProvider *)pictureProvider {
    if (!_pictureProvider) {
        _pictureProvider = [[PicturesProvider alloc] init];
        _pictureProvider.managedObjectContext = self.managedObjectContext;
    }
    return _pictureProvider;
}
@end

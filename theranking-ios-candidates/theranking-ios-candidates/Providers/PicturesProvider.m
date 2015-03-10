//
//  PicturesProvider.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "PicturesProvider.h"

NSInteger const kNumberOfPhotos = 60;
NSInteger const kImageSize = 4;

@implementation PicturesProvider

- (void)loadPicturesWithSuccess:(SuccessBlock)successBlock error:(ErrorBlock)errorBlock {
    NSDictionary* URLParams = @{
                                @"feature": @"popular",
                                @"rpp": [NSString stringWithFormat:@"%li?image_size=%li", (long)kNumberOfPhotos, (long)kImageSize],
                                @"consumer_key": kConsumerKey,
                                };
    [self.requestManager GET:self.requestManager.baseDomain parameters:URLParams completion:^(id data) {
        
    } error:^(id data, NSError *error) {
        
    }];
}

@end



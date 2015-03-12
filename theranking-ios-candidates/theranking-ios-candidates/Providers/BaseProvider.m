//
//  BaseProvider.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "BaseProvider.h"
#import "RequestManagerFactory.h"

NSString * const kConsumerKey = @"I7K8Q424HyKNtFYwG0TzY1N7UjIXHcwRAMa6nBnN";
static NSString * const kBaseDomain = @"https://api.500px.com/v1/photos";

@implementation BaseProvider

- (id<RequestManager>)requestManager {
    if (!_requestManager) {
        _requestManager = [RequestManagerFactory requestManager];
        _requestManager.baseDomain = kBaseDomain;
    }
    return _requestManager;
}

@end

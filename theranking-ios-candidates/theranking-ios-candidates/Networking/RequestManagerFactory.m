//
//  RequestManagerFactory.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "RequestManagerFactory.h"
#import "NetworkFetcher.h"

@implementation RequestManagerFactory

+ (id<RequestManager>)requestManager {
    return [[NetworkFetcher alloc] init];
}

@end

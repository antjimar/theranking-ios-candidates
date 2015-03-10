//
//  RequestManagerFactory.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "RequestManagerFactory.h"
#import "RequestManager.h"

@implementation RequestManagerFactory

+ (id<RequestManagerProtocol>)requestManager {
    return [[RequestManager alloc] init];
}

@end

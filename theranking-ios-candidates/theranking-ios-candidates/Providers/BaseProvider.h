//
//  BaseProvider.h
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestManager.h"
@import CoreData;

extern NSString * const kConsumerKey;

@interface BaseProvider : NSObject

@property (strong, nonatomic) id<RequestManager> requestManager;
@property (strong, nonatomic) NSManagedObjectContext *backgroundManagedObjectContext;

@end

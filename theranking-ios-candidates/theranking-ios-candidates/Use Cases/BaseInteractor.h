//
//  BaseInteractor.h
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@interface BaseInteractor : NSObject

@property (strong, nonatomic) NSManagedObjectContext *backgroundManagedObjectContext;

@end

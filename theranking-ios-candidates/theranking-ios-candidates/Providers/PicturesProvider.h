//
//  PicturesProvider.h
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "BaseProvider.h"
#import "CoreDataStack.h"

typedef void (^SuccessBlock)(id data);
typedef void (^ErrorBlock)(id data, NSError *error);

@interface PicturesProvider : BaseProvider

- (instancetype)initWithBackgroundManagedObjectContext:(NSManagedObjectContext *)backgroundManagedObjectContext;
- (void)loadPicturesWithSuccess:(SuccessBlock)successBlock error:(ErrorBlock)errorBlock;

@end

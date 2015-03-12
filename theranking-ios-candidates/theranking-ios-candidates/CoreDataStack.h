//
//  CoreDataStack.h
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;
@interface CoreDataStack : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectContext *backgroundManagedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (instancetype)initWithModelName:(NSString *)modelName;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

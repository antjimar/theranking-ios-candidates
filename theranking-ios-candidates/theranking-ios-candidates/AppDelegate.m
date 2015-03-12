//
//  AppDelegate.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "AppDelegate.h"
#import "CoreDataStack.h"
#import "MainPictureViewController.h"
#import "PictureEntity+Builder.h"

static NSString * const kModelName = @"theranking_ios_candidates";
static CGFloat const kMarginCells = 0.0f;

@interface AppDelegate ()
@property (strong, nonatomic) CoreDataStack *coreDataStack;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self customiseAppeareance];
    self.coreDataStack = [[CoreDataStack alloc] initWithModelName:kModelName];
    self.managedObjectContext = self.coreDataStack.managedObjectContext;
    
    UICollectionViewFlowLayout *layout = [self setupLayout];
    NSFetchedResultsController *results = [self setupNSFetchResultsController];
    
    MainPictureViewController *mainViewController = [[MainPictureViewController alloc] initWithFetchedResultsController:results
                                                                                                                 layout:layout
                                                                                                           andIndicator:nil];
    mainViewController.coreDataStack = self.coreDataStack;
    UINavigationController *navigatinoVC = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    [self.window setRootViewController:navigatinoVC];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self.coreDataStack saveContext];
}

#pragma mark - Setup Methods
- (UICollectionViewFlowLayout *)setupLayout {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = kMarginCells;
    layout.itemSize = CGSizeMake(screenWidth, screenWidth);
    
    return layout;
}
- (NSFetchedResultsController *)setupNSFetchResultsController {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:kPictureEntityName];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:PictureEntityAttributes.pictureRating ascending:NO]];
    
    NSFetchedResultsController *results = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                              managedObjectContext:self.coreDataStack.managedObjectContext
                                                                                sectionNameKeyPath:nil
                                                                                         cacheName:nil];
    return results;
}

#pragma mark - Appearance Methods
- (void)customiseAppeareance {
    UIColor *titleTextColor = [UIColor colorWithRed:186.0f/255.0f green:193.0f/255.0f blue:200.0f/255.0f alpha:1.0];
    UIColor *navBarBackgroundColor = [UIColor colorWithRed:34.0f/255.0f green:34.0f/255.0f blue:34.0f/255.0f alpha:1.0];
    NSShadow *shadow = [NSShadow new];
    [shadow setShadowColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8]];
    [shadow setShadowOffset: CGSizeMake(0.0f, 0.5f)];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:titleTextColor,
                                                           NSShadowAttributeName: shadow,}];
    [[UINavigationBar appearance] setTintColor:titleTextColor];
    [[UINavigationBar appearance] setBarTintColor:navBarBackgroundColor];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:titleTextColor,
                                                           NSShadowAttributeName: shadow,} forState:UIControlStateNormal];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

@end

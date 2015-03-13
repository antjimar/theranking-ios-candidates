//
//  MainViewController.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "MainPictureViewController.h"
#import "LoadPicturesInteractor.h"
#import "LoadPictureDetailsInteractor.h"
#import "DetailPictureViewController.h"
#import "PictureEntityProtocol.h"
#import "PictureEntityCellProtocol.h"
#import "PictureEntityFactory.h"
#import "NavigationTransitionAnimator.h"

static NSString *cellId = @"PictureCellId";

@interface MainPictureViewController ()<UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UILabel *labelIndicator;
@property (strong, nonatomic) LoadPictureDetailsInteractor *loadDetailsInteractor;

@end

@implementation MainPictureViewController

- (id)initWithFetchedResultsController:(NSFetchedResultsController *)resultsController
                                layout:(UICollectionViewLayout *)layout
                          andIndicator:(UIActivityIndicatorView *)activityIndicator {
    self = [super initWithFetchedResultsController:resultsController layout:layout];
    if (self) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_activityIndicator setHidden:YES];
        [_activityIndicator stopAnimating];
        _labelIndicator = [[UILabel alloc] init];
        self.title = @"500px";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    self.collectionView.backgroundColor = [UIColor colorWithRed:222.0f/255.0f green:222.0f/255.0f blue:222.0f/255.0f alpha:0.8];
    [self registerNib];
    [self setupAcitivityIndicator];
    [self setupRefreshController];
    [self loadDataFromServer:nil];
}

#pragma mark - Data Source Methods
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // Stop activity because we have data :)
    [self stopActivityIndicator];
    
    id<PictureEntityProtocol> item = [self.fetchedResultsController objectAtIndexPath:indexPath];
    UICollectionViewCell<PictureEntityCellProtocol> *cell = [PictureEntityFactory cellForEntity:item
                                                                              forCollectionView:collectionView
                                                                                    atIndexPath:indexPath];
    [cell drawPictureEntity:item];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate Methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {    
    PictureEntity *picture = [self.loadDetailsInteractor loadDetailsAtIndexPath:indexPath
                                                   withFetchedResultsController:self.fetchedResultsController];
    
    DetailPictureViewController *detailVC = [[DetailPictureViewController alloc] initWithModel:picture];
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {
    [(id<PictureEntityCellProtocol>)cell animateElements];
}

#pragma mark - Transitions Methods
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    NavigationTransitionAnimator *animator = nil;
    animator = [[NavigationTransitionAnimator alloc] init];
    animator.operation = operation;
    
    return animator;
}

#pragma mark - Registration Methods
- (void)registerNib {
    [PictureEntityFactory registerCellsInCollectionView:self.collectionView];
}

#pragma mark - Activity Indicator Methods
- (void)initActivityIndicator {
    self.labelIndicator = [self createLabelLoadingWithText:@"The images are coming :)..."];
    [self.view addSubview:self.labelIndicator];
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
}
- (void)stopActivityIndicator {
    [self.activityIndicator stopAnimating];
    [self.activityIndicator setHidden:YES];
    [self.labelIndicator removeFromSuperview];
}

#pragma mark - SetUp and Utils Methods
- (void)loadDataFromServer:(id)sender {
    LoadPicturesInteractor *loadPicturesInteractor = [[LoadPicturesInteractor alloc] initWithCoreDataStack:self.coreDataStack];
    [loadPicturesInteractor listOfPicuresWithCompletionBlock:^(NSArray *pictures) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.activityIndicator.isAnimating) {
                [self stopActivityIndicator];
            }
            if (sender) {
                [(UIRefreshControl *)sender endRefreshing];
            }
        });
    }];
}
- (void)setupAcitivityIndicator {
    // Center and start animating
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.center = CGPointMake(self.view.bounds.size.width / 2.0f, self.view.bounds.size.width / 2.0f);
    [self initActivityIndicator];
}
- (UILabel *)createLabelLoadingWithText:(NSString *)text {
    CGFloat labelY = self.activityIndicator.frame.size.height + self.activityIndicator.frame.origin.y + 5;
    // Label harcode position. Revise
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2.0f - 60, labelY, 250.0f, 25.0f)];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.font = [UIFont boldSystemFontOfSize:12.0f];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor grayColor];
    label.text = text;
    
    return label;
}
- (void)setupRefreshController {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self
                       action:@selector(refresh:)
             forControlEvents:UIControlEventValueChanged];    
    [self.collectionView addSubview:refreshControl];
    self.collectionView.alwaysBounceVertical = YES;
}
- (void)refresh:(id)sender {
    [self loadDataFromServer:sender];
}

#pragma mark - Lazy instantation Methods
-(LoadPictureDetailsInteractor *)loadDetailsInteractor {
    if (!_loadDetailsInteractor) {
        _loadDetailsInteractor = [[LoadPictureDetailsInteractor alloc] initWithCoreDataStack:self.coreDataStack];
    }
    return _loadDetailsInteractor;
}

@end

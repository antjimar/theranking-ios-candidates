//
//  MainViewController.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "MainPictureViewController.h"
#import "PictureCollectionViewCell.h"
#import "PictureEntity.h"
#import "LoadPicturesInteractor.h"
#import <SDWebImage/UIImageView+WebCache.h>

static NSString *cellId = @"PictureCellId";

@interface MainPictureViewController ()

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UILabel *labelIndicator;

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
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self registerNib];
    
    [self setupAcitivityIndicator];
    
    LoadPicturesInteractor *loadPicturesInteractor = [[LoadPicturesInteractor alloc] initWithCoreDataStack:self.coreDataStack];
    [loadPicturesInteractor listOfPicuresWithCompletionBlock:^(NSArray *pictures) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.activityIndicator.isAnimating) {
                [self stopActivityIndicator];
            }
        });
    }];
}

#pragma mark - Data Source Methods
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // Stop activity because we have data :)
    [self stopActivityIndicator];

    PictureEntity *picture = [self.fetchedResultsController objectAtIndexPath:indexPath];
    PictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId
                                                                                forIndexPath:indexPath];
    cell.pictureNameLabel.text = picture.pictureName;
    cell.ratingLabel.text = [NSString stringWithFormat:@"%@", picture.pictureRating];
    [cell.pictureImageView sd_setImageWithURL:[NSURL URLWithString:picture.pictureImgURL]
                             placeholderImage:[UIImage imageNamed:@"500px-logo1"]];
    // Devolverla
    return cell;
}

#pragma mark - UICollectionViewDelegate Methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Registration Methods
- (void)registerNib {
    UINib *nib = [UINib nibWithNibName:@"PictureCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:cellId];
}

#pragma mark - Activity Indicator Methods
- (void)initActivityIndicator {
    // Ponemos una label "Cargando imagen"
    self.labelIndicator = [self createLabelLoadingWithText:@"The images are coming :)..."];
    [self.view addSubview:self.labelIndicator];
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
}
- (void)stopActivityIndicator {
    [self.activityIndicator stopAnimating];
    [self.activityIndicator setHidden:YES];
    [self.labelIndicator removeFromSuperview];
//    [self.labelIndicator setHidden:YES];

}

#pragma mark - Utils Methods
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

@end

//
//  DetailPictureViewController.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "DetailPictureViewController.h"
#import "PictureEntity+Builder.h"
#import "NavigationTransitionAnimator.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DetailPictureViewController ()

@property (strong, nonatomic) PictureEntity *pictureModel;

@end

@implementation DetailPictureViewController

#pragma mark - View lifecycle Methods
- (instancetype)initWithModel:(PictureEntity *)pictureModel {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _pictureModel = pictureModel;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userImageView.clipsToBounds = YES;
    self.userImageView.layer.cornerRadius = self.userImageView.bounds.size.height / 2.0f;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = self.pictureModel.pictureName;
    [self syncModelWithView];
}


#pragma mark - Utils Methods
- (void)syncModelWithView {
    [self.userImageView sd_cancelCurrentImageLoad];

    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:self.pictureModel.pictureUserAvatarURL]
                          placeholderImage:[UIImage imageNamed:@"500px-logo1"]];

    self.userFullNameLabel.text = self.pictureModel.pictureUserFullName;
    self.cameraLabel.text = self.pictureModel.pictureCamera;
    self.cameraLensLabel.text = self.pictureModel.pictureCameraLens;
    self.cameraFocalLenthLabel.text = self.pictureModel.pictureCameraFocalLength;
    self.cameraIsoLabel.text = self.pictureModel.pictureCameraISO;
    self.cameraShutterSpeedLabel.text = self.pictureModel.pictureCameraShutterSpeed;
    self.cameraApertureLabel.text = self.pictureModel.pictureCameraAperture;
    self.pictureDescriptionLabel.text = self.pictureModel.pictureDescription;
    
    [self setUpMap];
}
- (void)setUpMap {
    if (self.pictureModel.pictureLatitud == nil || self.pictureModel.pictureLongitud == nil) {
        [self.pictureMapView setHidden:YES];
        [self.heightMapConstraint setConstant:10.0f];
        
    } else {
        [self.pictureMapView setHidden:NO];
        CLLocationCoordinate2D locationPicture = CLLocationCoordinate2DMake([self.pictureModel.pictureLatitud doubleValue],
                                                                            [self.pictureModel.pictureLongitud doubleValue]);
        MKCoordinateSpan coordinateSpan = MKCoordinateSpanMake(1, 1);
        MKCoordinateRegion coordinateRegion = MKCoordinateRegionMake(locationPicture, coordinateSpan);
        [self.pictureMapView setRegion:coordinateRegion animated:YES];
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setCoordinate:locationPicture];
        
        // Get Address
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[self.pictureModel.pictureLatitud doubleValue]
                                                          longitude:[self.pictureModel.pictureLongitud doubleValue]];
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            if (placemarks.count) {
                NSDictionary *dictionary = [[placemarks objectAtIndex:0] addressDictionary];
                [annotation setTitle:dictionary[@"City"]];
                [annotation setSubtitle:dictionary[@"Country"]];
            } else {
                [annotation setTitle:self.pictureModel.pictureName];
            }
            [self.pictureMapView addAnnotation:annotation];

        }];
    }
}
@end

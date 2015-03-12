//
//  DetailPictureViewController.h
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;
@class PictureEntity;

@interface DetailPictureViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userFullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cameraLabel;
@property (weak, nonatomic) IBOutlet UILabel *cameraLensLabel;
@property (weak, nonatomic) IBOutlet UILabel *cameraFocalLenthLabel;
@property (weak, nonatomic) IBOutlet UILabel *cameraIsoLabel;
@property (weak, nonatomic) IBOutlet UILabel *cameraShutterSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *cameraApertureLabel;
@property (weak, nonatomic) IBOutlet UILabel *pictureDescriptionLabel;
@property (weak, nonatomic) IBOutlet MKMapView *pictureMapView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightMapConstraint;

@property (strong, nonatomic) NSIndexPath *indexPathFromViewController;

- (instancetype)initWithModel:(PictureEntity *)pictureModel;

@end

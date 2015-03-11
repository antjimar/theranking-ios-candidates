//
//  DetailPictureViewController.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "DetailPictureViewController.h"
#import "PictureEntity+Builder.h"
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
        self.title = pictureModel.pictureName;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self syncModelWithView];
}

#pragma mark - Utils Methods
- (void)syncModelWithView {
//    [self.userImageView sd_cancelCurrentImageLoad];

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
}







@end

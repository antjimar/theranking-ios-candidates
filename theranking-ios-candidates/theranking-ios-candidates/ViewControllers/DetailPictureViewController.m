//
//  DetailPictureViewController.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "DetailPictureViewController.h"
#import "PictureEntity+Builder.h"

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
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self syncModelWithView];
}

#pragma mark - Utils Methods
- (void)syncModelWithView {
    
}

@end

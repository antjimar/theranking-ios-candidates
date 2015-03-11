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

static NSString *cellId = @"PictureCellId";

@interface MainPictureViewController ()

@end

@implementation MainPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.title = @"500px";
    [self registerNib];
}

#pragma mark - Data Source Methods
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // Obtener el objeto modelo
    PictureEntity *picture = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Crear la celda
    PictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId
                                                                                forIndexPath:indexPath];
    
    // Configurarla
    cell.testLabel.text = picture.pictureName;
    
    // Devolverla
    return cell;
}

#pragma mark - Registration Methods
- (void)registerNib {
    UINib *nib = [UINib nibWithNibName:@"PictureCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:cellId];
}

@end

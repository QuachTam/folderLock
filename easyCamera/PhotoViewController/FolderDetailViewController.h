//
//  PhotoViewController.h
//  easyCamera
//
//  Created by ATam on 6/12/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FolderModel;
@interface FolderDetailViewController : UIViewController
@property (nonatomic, strong) FolderModel *folderModel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

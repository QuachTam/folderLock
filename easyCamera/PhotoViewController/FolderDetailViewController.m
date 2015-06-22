//
//  PhotoViewController.m
//  easyCamera
//
//  Created by ATam on 6/12/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "FolderDetailViewController.h"
#import "CameraObject.h"
#import "ButtonHelper.h"
#import "FolderModel.h"
#import "PhotoModel.h"
#import "FolderDetailCollectionViewCell.h"
#import "chooseFolderService.h"
#import "VCPhotoPageController.h"
#import "MMNavigationBar.h"

@interface FolderDetailViewController ()<CameraObject, UICollectionViewDataSource, UICollectionViewDelegate, UIActionSheetDelegate>
@property (nonatomic, strong) chooseFolderService *service;
@end

@implementation FolderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self resetModel];
    [self setTitle:self.folderModel.name];
    UIButton *cameraButton = moreButton();
    [cameraButton addTarget:self action:@selector(showMore) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cameraButton];
    
    UINib *cellNib = [UINib nibWithNibName:@"FolderDetailCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"cvCell"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(100, 100)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    [self.collectionView setCollectionViewLayout:flowLayout];
}

- (void)resetModel {
    self.folderModel.name = nil;
    self.folderModel.listPhotoModel = nil;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.folderModel.listPhotoModel.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;
    CGSize size = flowLayout.itemSize;
    return size;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cvCell";
    
    FolderDetailCollectionViewCell *cell = (FolderDetailCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    PhotoModel *photoModel = [self.folderModel.listPhotoModel objectAtIndex:indexPath.row];
    cell.image.layer.borderWidth = 1.f;
    cell.image.layer.borderColor = [UIColor blackColor].CGColor;
    [cell.image setImage:photoModel.image];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self showPhotoPageControllerAtIndex:indexPath.row];
}

#pragma mark - photo detail

- (void)showPhotoPageControllerAtIndex:(NSInteger)index
{
    VCPhotoPageController * photoPageController = [[VCPhotoPageController alloc] initWithPhotos:self.folderModel.listPhotoModel];
    [photoPageController setPageIndex:index];
    UINavigationController *navController = [[UINavigationController alloc] initWithNavigationBarClass:[MMNavigationBar class] toolbarClass:nil];
    [navController setViewControllers:@[photoPageController]];
    [self presentViewController:navController animated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showCameraPicker:(UIImagePickerControllerSourceType)sourceType
                          
{
    CameraObject *camera = [CameraObject shareInstance];
    camera.delegate = self;
    camera.supperView = self;
    camera.sourceType = sourceType;
    [camera showCamera];
}

- (void)showMore {
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Choose Photo", nil];
    [action showInView:self.view];
}

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==1) {
        [self showCameraPicker:UIImagePickerControllerSourceTypePhotoLibrary];
    }else if (buttonIndex==2){
        [self showCameraPicker:UIImagePickerControllerSourceTypeCamera];
    }
}

- (void)didFinishPickingMediaWithInfo:(UIImage *)image {
    if (!self.service) {
        self.service = [[chooseFolderService alloc] init];
    }
    [self.service saveImageToFolder:self.folderModel image:image success:^{
        [self resetModel];
        [self.collectionView reloadData];
    }];
}

- (void)imagePickerControllerDidCancel {
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

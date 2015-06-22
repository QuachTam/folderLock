//
//  ListFolderViewController.m
//  easyCamera
//
//  Created by ATam on 6/12/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "ListFolderViewController.h"
#import "ButtonHelper.h"
#import "CameraObject.h"
#import "FolderModel.h"
#import "ListFolderService.h"
#import "FolderDetailViewController.h"
#import "CreateFolderViewController.h"
#import "MMNavigationBar.h"
#import "ListFolderTableViewCell.h"
#import "ListFolderChooseViewController.h"

static NSString *listFolderTableViewCell = @"ListFolderTableViewCell";

@interface ListFolderViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, CameraObject, UITextFieldDelegate>
@property (nonatomic, strong) ListFolderService *service;
@end

@implementation ListFolderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"List Folder"];
    UIButton *cameraButton = showCameraButton();
    [cameraButton setTitle:@"Camera" forState:UIControlStateNormal];
    [cameraButton addTarget:self action:@selector(showCameraPicker) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cameraButton];
    
    UIButton *folderButton = addFolderButton();
    [folderButton addTarget:self action:@selector(addFolder:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:folderButton];
    
    [self registerTableViewCell];
    [self fetchResults];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)registerTableViewCell {
    [self.tbView registerNib:[UINib nibWithNibName:NSStringFromClass([ListFolderTableViewCell class]) bundle:nil] forCellReuseIdentifier:listFolderTableViewCell];
}

- (void)fetchResults {
    __weak __typeof(self)week = self;
    if (!self.service) {
        self.service = [[ListFolderService alloc] init];
    }
    self.service.didFinishFetchResults = ^{
        __strong __typeof(week)strong = week;
        if (strong.service.listModelFolder.count) {
            [strong showCameraPicker];
        }
        [strong.tbView reloadData];
    };
    self.service.didChangeContent = ^{
        __strong __typeof(week)strong = week;
        [strong.tbView beginUpdates];
    };
    self.service.willChangeContent = ^{
        __strong __typeof(week)strong = week;
        [strong.tbView endUpdates];
    };
    self.service.resultsChangeInsert = ^(NSArray *indexPaths) {
         __strong __typeof(week)strong = week;
        [strong.tbView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    };
    self.service.resultsChangeUpdate = ^(NSArray *indexPaths) {};
    self.service.resultsChangeMove = ^(NSArray *indexPaths) {};
    self.service.resultsChangeDelete = ^(NSArray *indexPaths) {};
    
    [self.service fetchDatabase];
}

- (void)showCameraPicker
{
    if (self.service.listModelFolder.count) {
        CameraObject *camera = [CameraObject shareInstance];
        camera.delegate = self;
        camera.supperView = self;
        camera.sourceType = UIImagePickerControllerSourceTypeCamera;
        [camera showCamera];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please create folder" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

- (void)addFolder:(id)sender {
    CreateFolderViewController *createFolder = [[CreateFolderViewController alloc] initWithNibName:NSStringFromClass([CreateFolderViewController class]) bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithNavigationBarClass:[MMNavigationBar class] toolbarClass:nil];
    [nav setViewControllers:@[createFolder]];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didFinishPickingMediaWithInfo:(UIImage *)image {
    ListFolderChooseViewController *choose = [[ListFolderChooseViewController alloc] initWithNibName:NSStringFromClass([ListFolderChooseViewController class]) bundle:nil];
    choose.image = image;
    choose.listFolder = self.service.listModelFolder;
    UINavigationController *nav = [[UINavigationController alloc] initWithNavigationBarClass:[MMNavigationBar class] toolbarClass:nil];
    [nav setViewControllers:@[choose]];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.service.listModelFolder.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListFolderTableViewCell *cell = [self.tbView dequeueReusableCellWithIdentifier:listFolderTableViewCell forIndexPath:indexPath];
    [cell setValueForCell:[self.service.listModelFolder objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FolderModel *model = [self.service.listModelFolder objectAtIndex:indexPath.row];
    if (model.isPassword) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Enter Your Password" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        alertView.tag = indexPath.row;
        [alertView show];
    }else{
        [self gotoFolderDetailViewController:model];
    }
}

- (void)gotoFolderDetailViewController:(FolderModel *)folderModel {
    
    FolderDetailViewController *photoVC = [[FolderDetailViewController alloc] initWithNibName:NSStringFromClass([FolderDetailViewController class]) bundle:nil];
    photoVC.folderModel = folderModel;
    [self.navigationController pushViewController:photoVC animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    UITextField * alertTextField = [alertView textFieldAtIndex:0];
    FolderModel *model = [self.service.listModelFolder objectAtIndex:alertView.tag];
    if ([alertTextField.text isEqualToString:model.password]) {
        [self.view endEditing:YES];
        [self performSelector:@selector(gotoFolderDetailViewController:) withObject:model afterDelay:1];
    }
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

//
//  CreateFolderViewController.m
//  easyCamera
//
//  Created by ATam on 6/12/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "CreateFolderViewController.h"
#import "ButtonHelper.h"
#import "TextFieldTableViewCell.h"
#import "CreateFolderService.h"

static NSString *textFieldIdentifier = @"textFieldIdentifier";

@interface CreateFolderViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) NSString *stringFolderName;
@property (nonatomic, strong) NSString *stringPassowrd;
@property (nonatomic, strong) NSString *stringRePassowrd;

@property (nonatomic, strong) CreateFolderService *service;
@end

@implementation CreateFolderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Create Folder";
    
    UIButton *cancelBtn = cancelButton();
    [cancelBtn addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    
    UIButton *saveBtn = saveButton();
    [saveBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    
    [self registerTableViewCell];
}

- (void)registerTableViewCell {
    [self.tbView registerNib:[UINib nibWithNibName:NSStringFromClass([TextFieldTableViewCell class]) bundle:nil] forCellReuseIdentifier:textFieldIdentifier];
}

- (void)dismissViewController {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveAction:(id)sender {
    [self.view endEditing:YES];
    if (!self.service) {
        self.service = [[CreateFolderService alloc] init];
    }
    NSString *message = [self.service checkValidNameFolder:self.stringFolderName password:self.stringPassowrd rePassowrd:self.stringRePassowrd];
    if (message.length) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }else{
        [self.service saveFolder:self.stringFolderName password:self.stringPassowrd success:^{
            [self dismissViewController];
        }];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:tableView.bounds];
    view.backgroundColor = tableView.backgroundColor;
    return view;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextFieldTableViewCell *cell = [self.tbView dequeueReusableCellWithIdentifier:textFieldIdentifier forIndexPath:indexPath];
    [self textFieldCell:indexPath TextFieldTableViewCell:cell];
    return cell;
}

- (void)textFieldCell:(NSIndexPath*)indexPath TextFieldTableViewCell:(TextFieldTableViewCell*)cell{
    if (indexPath.row==0) {
        [cell setValueTextField:@"Folder Name"];
        cell.textField.secureTextEntry = NO;
    }else if (indexPath.row==1){
        [cell setValueTextField:@"Password"];
        cell.textField.secureTextEntry = YES;
    }else{
        [cell setValueTextField:@"Re-Passoword"];
        cell.textField.secureTextEntry = YES;
    }
    cell.textField.delegate = self;
    cell.textField.tag = indexPath.row;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag==0) {
        self.stringFolderName = textField.text;
    }else if(textField.tag==1){
        self.stringPassowrd = textField.text;
    }else{
        self.stringRePassowrd = textField.text;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

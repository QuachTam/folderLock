//
//  ButtonHelper.m
//  easyCamera
//
//  Created by ATam on 6/12/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "ButtonHelper.h"
#import "ImageHelper.h"

UIButton * showCameraButton() {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *title = @"Camera";
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    button.frame = CGRectMake(0.f, 0.f, 70.f, 30.f);
    
    button.layer.cornerRadius = 4.f;
    button.layer.borderColor = [UIColor greenColor].CGColor;
    button.layer.borderWidth = 1.f;
    
    button.titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:14.f];
    UIImage *image = mm_solidColorImageWithSize([UIColor colorWithRed:81/255.f green:139/255.f blue:69/255.f alpha:1].CGColor,
                                            CGSizeMake(1.f, 1.f));
    [button setBackgroundImage:image forState:UIControlStateNormal];
    return button;
}

UIButton * moreButton() {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *title = @"More...";
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    button.frame = CGRectMake(0.f, 0.f, 70.f, 30.f);
    
    button.layer.cornerRadius = 4.f;
    button.layer.borderColor = [UIColor greenColor].CGColor;
    button.layer.borderWidth = 1.f;
    
    button.titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:14.f];
    UIImage *image = mm_solidColorImageWithSize([UIColor colorWithRed:81/255.f green:139/255.f blue:69/255.f alpha:1].CGColor,
                                                CGSizeMake(1.f, 1.f));
    [button setBackgroundImage:image forState:UIControlStateNormal];
    return button;
}

UIButton * cancelButton() {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *title = @"Cancel";
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    button.frame = CGRectMake(0.f, 0.f, 70.f, 30.f);
    
    button.layer.cornerRadius = 4.f;
    button.layer.borderColor = [UIColor greenColor].CGColor;
    button.layer.borderWidth = 1.f;
    
    button.titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:14.f];
    UIImage *image = mm_solidColorImageWithSize([UIColor colorWithRed:81/255.f green:139/255.f blue:69/255.f alpha:1].CGColor,
                                                CGSizeMake(1.f, 1.f));
    [button setBackgroundImage:image forState:UIControlStateNormal];
    return button;
}

UIButton * backButton() {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *title = @"Back";
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    button.frame = CGRectMake(0.f, 0.f, 70.f, 30.f);
    
    button.layer.cornerRadius = 4.f;
    button.layer.borderColor = [UIColor greenColor].CGColor;
    button.layer.borderWidth = 1.f;
    
    button.titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:14.f];
    UIImage *image = mm_solidColorImageWithSize([UIColor colorWithRed:81/255.f green:139/255.f blue:69/255.f alpha:1].CGColor,
                                                CGSizeMake(1.f, 1.f));
    [button setBackgroundImage:image forState:UIControlStateNormal];
    return button;
}

UIButton * saveButton() {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *title = @"Save";
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    button.frame = CGRectMake(0.f, 0.f, 70.f, 30.f);
    
    button.layer.cornerRadius = 4.f;
    button.layer.borderColor = [UIColor greenColor].CGColor;
    button.layer.borderWidth = 1.f;
    
    button.titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:14.f];
    UIImage *image = mm_solidColorImageWithSize([UIColor colorWithRed:81/255.f green:139/255.f blue:69/255.f alpha:1].CGColor,
                                                CGSizeMake(1.f, 1.f));
    [button setBackgroundImage:image forState:UIControlStateNormal];
    return button;
}

UIButton * addFolderButton() {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *title = @"New Folder";
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    button.frame = CGRectMake(0.f, 0.f, 90.f, 30.f);
    
    button.layer.cornerRadius = 4.f;
    button.layer.borderColor = [UIColor greenColor].CGColor;
    button.layer.borderWidth = 1.f;
    
    button.titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:14.f];
    
    [button setBackgroundImage:mm_solidColorImageWithSize([UIColor colorWithRed:81/255.f green:139/255.f blue:69/255.f alpha:1].CGColor,
                                                          CGSizeMake(1.f, 1.f)) forState:UIControlStateNormal];
    
    return button;
}

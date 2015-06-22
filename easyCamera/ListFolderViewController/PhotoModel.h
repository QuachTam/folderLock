//
//  PhotoModel.h
//  easyCamera
//
//  Created by ATam on 6/13/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"
#import <UIKit/UIKit.h>

@interface PhotoModel : NSObject
@property (strong, nonatomic) UIImage *image;
@property (nonatomic, strong) NSDate *createDate;
- (instancetype)initWithPhotoEntity:(Photo*)entity;
@end

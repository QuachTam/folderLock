//
//  PhotoModel.m
//  easyCamera
//
//  Created by ATam on 6/13/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "PhotoModel.h"
#import "Photo.h"

@interface PhotoModel()
@property (nonatomic, strong) Photo *photo;
@end

@implementation PhotoModel
- (instancetype)initWithPhotoEntity:(Photo*)entity {
    self = [super init];
    if (self) {
        self.photo = entity;
    }
    return self;
}

- (NSDate *)createDate {
    if (!_createDate) {
        _createDate = self.photo.createDate;
    }
    return _createDate;
}

- (UIImage *)image {
    if (!_image) {
        _image = [UIImage imageWithData:self.photo.image];
    }
    return _image;
}
@end

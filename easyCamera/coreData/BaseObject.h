//
//  BaseObject.h
//  easyCamera
//
//  Created by ATam on 6/12/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BaseObject : NSManagedObject

@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSNumber * index;

@end

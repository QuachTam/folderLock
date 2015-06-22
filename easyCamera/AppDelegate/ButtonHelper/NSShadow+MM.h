//
//  NSShadow+MM.h
//  Mobilimeet
//
//  Created by Daniel Ericsson on 2013-11-08.
//  Copyright (c) 2013 Mobilimeet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSShadow (MM)

+ (instancetype)shadowWithColor:(UIColor *)color offset:(CGSize)offset blurRadius:(CGFloat)radius;

@end

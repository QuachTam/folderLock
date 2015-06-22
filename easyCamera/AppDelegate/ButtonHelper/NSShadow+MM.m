//
//  NSShadow+MM.m
//  Mobilimeet
//
//  Created by Daniel Ericsson on 2013-11-08.
//  Copyright (c) 2013 Mobilimeet. All rights reserved.
//

#import "NSShadow+MM.h"

@implementation NSShadow (MM)

+ (instancetype)shadowWithColor:(UIColor *)color offset:(CGSize)offset blurRadius:(CGFloat)radius {
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = color;
    shadow.shadowOffset = offset;
    shadow.shadowBlurRadius = radius;
    
    return shadow;
}

@end

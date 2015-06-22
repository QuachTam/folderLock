//
//  MMNavigationBar.m
//  Mobilimeet
//
//  Copyright (c) 2013 Mobilimeet AB. All rights reserved.
//

#import "MMNavigationBar.h"
// -- Utils
#import "NSShadow+MM.h"
#import "ImageHelper.h"

@implementation MMNavigationBar

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }

    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }

    return self;
}

- (void)commonInit {
    [self setBackgroundImage:mm_solidColorImageWithSize([UIColor colorWithRed:81/255.0 green:139/255.0 blue:69/255.0 alpha:1].CGColor,
                                                        CGSizeMake(1.f, 1.f)) forBarMetrics:UIBarMetricsDefault];

    self.tintColor = [UIColor whiteColor];
    self.barStyle = UIBarStyleBlack;

	NSDictionary *titleAttrs = @
	{
		NSForegroundColorAttributeName: [UIColor whiteColor],
		NSShadowAttributeName: [NSShadow shadowWithColor:nil offset:CGSizeZero blurRadius:0.f],
		NSFontAttributeName: [UIFont systemFontOfSize:20]
	};

    self.titleTextAttributes = titleAttrs;
    [self setShadowImage:[UIImage new]];
    self.translucent = NO;
}

@end

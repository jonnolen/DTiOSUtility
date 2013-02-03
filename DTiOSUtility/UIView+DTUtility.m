//
//  UIView+PBCategory.m
//  PassagewaysBoard
//
//  Created by Jonathan Nolen on 10/4/12.
//  Copyright (c) 2012 Passageways. All rights reserved.
//

#import "UIView+DTUtility.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (DTUtility)

- (UIImage *)viewSnapshot
{
    UIGraphicsBeginImageContextWithOptions([self bounds].size, self.opaque, 0.0);
    [[self layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end

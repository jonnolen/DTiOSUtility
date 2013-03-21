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

- (UIImage *)viewSnapshotForCGGraphicsContext
{
    return [self viewSnapshot:YES];
}

-(UIImage *)viewSnapshotForUIGraphicsContext{
    return [self viewSnapshot:NO];
}

-(UIImage *)viewSnapshot:(BOOL)inverted{
    UIGraphicsBeginImageContextWithOptions([self bounds].size, self.opaque, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    if (inverted){
        CGContextTranslateCTM(ctx, 0.0, CGRectGetHeight(self.bounds));
        CGContextScaleCTM(ctx, 1.0, -1.0);
    }
    
    
    [[self layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    ctx = nil;
    UIGraphicsEndImageContext();
    
    return image;

}
@end

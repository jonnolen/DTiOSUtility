//  UIView+DTCategory.h
//  Created by Jonathan Nolen on 10/4/12.

#import <UIKit/UIKit.h>

@interface UIView (DTUtility)
- (UIImage *)viewSnapshotForCGGraphicsContext;
- (UIImage *)viewSnapshotForUIGraphicsContext;
@end

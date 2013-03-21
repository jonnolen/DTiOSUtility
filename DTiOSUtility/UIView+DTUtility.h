//
//  UIView+PBCategory.h
//  PassagewaysBoard
//
//  Created by Jonathan Nolen on 10/4/12.
//  Copyright (c) 2012 Passageways. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DTUtility)
- (UIImage *)viewSnapshotForCGGraphicsContext;
- (UIImage *)viewSnapshotForUIGraphicsContext;
@end

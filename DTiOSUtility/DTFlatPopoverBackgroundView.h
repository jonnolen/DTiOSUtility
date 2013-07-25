//
//  EOTeamListPopOverBackgroundView.h
//  Exec Online
//
//  Created by Jonathan Nolen on 7/24/13.
//  Copyright (c) 2013 Exec Online. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTFlatPopoverBackgroundView : UIPopoverBackgroundView

@property (nonatomic, readonly) UIColor *borderColor;
@property (nonatomic, readonly) BOOL hasShadow;

+(CGFloat)borderWidth;

@end

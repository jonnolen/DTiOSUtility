//
//  DTTeamListPopOverBackgroundView.h
//  Created by Jonathan Nolen on 7/24/13.

#import <UIKit/UIKit.h>

@interface DTFlatPopoverBackgroundView : UIPopoverBackgroundView

@property (nonatomic, readonly) UIColor *borderColor;
@property (nonatomic, readonly) BOOL hasShadow;

+(CGFloat)borderWidth;

@end

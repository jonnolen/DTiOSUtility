//
//  DTHighlightableBackgroundButton.m
//  Created by Jonathan Nolen on 8/22/13.

#import "DTHighlightableBackgroundButton.h"
#import <QuartzCore/QuartzCore.h>

@interface DTHighlightableBackgroundButton(){
    NSMutableDictionary *backgroundColorsByState;
}

@end

@implementation DTHighlightableBackgroundButton

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self initBackgroundColors];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]){
        [self initBackgroundColors];
    }
    return self;
}
-(void)initBackgroundColors{
    backgroundColorsByState = [@{} mutableCopy];
}

-(void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state{
    backgroundColorsByState[@(state)] = backgroundColor;
    [self updateBackgroundColorForState];
}

-(void)updateBackgroundColorForState{
    if (backgroundColorsByState[@(self.state)]){
        self.backgroundColor = (UIColor *)backgroundColorsByState[@(self.state)];
    }
    else if(self.state & UIControlStateHighlighted && backgroundColorsByState[@(UIControlStateHighlighted)]){
        self.backgroundColor = (UIColor *)backgroundColorsByState[@(UIControlStateHighlighted)];
    }
    else{
        self.backgroundColor = (UIColor *)backgroundColorsByState[@(UIControlStateNormal)];
    }
}

-(void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    [self updateBackgroundColorForState];
}

-(void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    [self updateBackgroundColorForState];
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    [self updateBackgroundColorForState];
}

@end

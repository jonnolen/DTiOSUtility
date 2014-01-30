//
//  DTTeamListPopOverBackgroundView.m
//  Created by Jonathan Nolen on 7/24/13.

#import "DTFlatPopoverBackgroundView.h"
#import <QuartzCore/QuartzCore.h>
#import <SSToolkit/SSDrawingUtilities.h>

const CGFloat ARROW_HEIGHT = 10.0f;
const CGFloat ARROW_BASE = 21.0f;

@interface DTFlatPopoverBackgroundView(){
    CGFloat _arrowOffset;
    UIPopoverArrowDirection _arrowDirection;
}

@property (nonatomic, strong) CALayer *arrowLayer;
@property (nonatomic, strong) CALayer *backgroundLayer;

@end

@implementation DTFlatPopoverBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self configure];
    }
    return self;
}

-(id)init{
    self = [super init];
    if (self){
        [self configure];
    }
    return self;
}

-(void)configure{
    self.arrowLayer = [CALayer new];

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(21, 10), NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 0, 10);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 10); //bottom left
    CGPathAddLineToPoint(path, NULL, 10, 0); //top middle.
    CGPathAddLineToPoint(path, NULL, 20, 10); //bottom right
    CGPathCloseSubpath(path); //bottom left.
    
    CGContextAddPath(context, path);
    CGContextSetFillColorWithColor(context, self.borderColor.CGColor);
    CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
    CGContextFillPath(context);
    CGContextStrokePath(context);
    UIImage *triangle = UIGraphicsGetImageFromCurrentImageContext();
    context = NULL;
    path = NULL;
    UIGraphicsEndImageContext();
    
    self.arrowLayer.contents = (__bridge id)triangle.CGImage;
    self.arrowLayer.anchorPoint = CGPointMake(.5, 1.0);
    self.arrowLayer.bounds = CGRectMake(0, 0, 21, 10);
    
    self.backgroundLayer = [CALayer new];
    self.backgroundLayer.backgroundColor = self.borderColor.CGColor;
    [self.layer addSublayer:self.backgroundLayer];
    [self.layer addSublayer:self.arrowLayer];


    if (self.hasShadow){
        self.clipsToBounds = NO;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = .3;
        self.layer.shadowRadius = 1.5 * ARROW_HEIGHT;
    }
    else{
        self.clipsToBounds = YES;
        self.layer.shadowOpacity = 0.0;
    }
}

+(UIEdgeInsets)contentViewInsets{
    CGFloat b = [self borderWidth];
    return UIEdgeInsetsMake(b, b, b, b);
}

+(CGFloat)arrowBase{
    return ARROW_BASE;
}
+(CGFloat)arrowHeight{
    return ARROW_HEIGHT;
}
+ (BOOL)wantsDefaultContentAppearance{
    return NO;
}

-(CGFloat)arrowOffset{
    return _arrowOffset;
}
-(void)setArrowOffset:(CGFloat)arrowOffset{
    if (arrowOffset != _arrowOffset){
        _arrowOffset = arrowOffset;
        [self setNeedsLayout];
    }
}

-(UIPopoverArrowDirection)arrowDirection{
    return _arrowDirection;
}

-(void)setArrowDirection:(UIPopoverArrowDirection)arrowDirection{
    if (arrowDirection != _arrowDirection){
        _arrowDirection = arrowDirection;
        [self setNeedsLayout];
    }
}

-(void)layoutSubviews{
    
    CGFloat yModification;
    CGFloat xModification;
    
    CGFloat heightModification;
    CGFloat widthModification;
    
    CGFloat xCoordinateForArrow;
    CGFloat yCoordinateForArrow;
    
    CGFloat rotationForArrow;
    CGSize shadowOffset;
    
    if (self.arrowDirection == UIPopoverArrowDirectionUp){
        yModification = .5 * ARROW_HEIGHT;
        heightModification = -ARROW_HEIGHT;
        xModification = 0;
        widthModification = 0;
        rotationForArrow = 0;
        xCoordinateForArrow = CGRectGetMidX(self.layer.bounds) + self.arrowOffset;
        yCoordinateForArrow = ARROW_HEIGHT;// + 1;
        shadowOffset = CGSizeMake(0, ARROW_HEIGHT);
    }
    if (self.arrowDirection == UIPopoverArrowDirectionDown){
        yModification = .5 * -ARROW_HEIGHT;
        heightModification = -ARROW_HEIGHT;
        xModification = 0;
        widthModification = 0;
        rotationForArrow = M_PI;
        xCoordinateForArrow = CGRectGetMidX(self.layer.bounds) + self.arrowOffset;
        yCoordinateForArrow = CGRectGetMaxY(self.layer.bounds) - ARROW_HEIGHT;// - 1;
        shadowOffset = CGSizeMake(0, -ARROW_HEIGHT);
    }
    if (self.arrowDirection == UIPopoverArrowDirectionRight){
        yModification = 0;
        heightModification = 0;
        xModification = .5 * -ARROW_HEIGHT;
        widthModification = -ARROW_HEIGHT;
        rotationForArrow = M_PI / 2;
        xCoordinateForArrow = CGRectGetMaxX(self.layer.bounds) - ARROW_HEIGHT;// - 1;
        yCoordinateForArrow = CGRectGetMidY(self.layer.bounds) + self.arrowOffset;
        shadowOffset = CGSizeMake(-ARROW_HEIGHT, 0);
    }
    if (self.arrowDirection == UIPopoverArrowDirectionLeft){
        yModification = 0;
        heightModification = 0;
        xModification = .5 * ARROW_HEIGHT;
        widthModification = -ARROW_HEIGHT;
        rotationForArrow = -M_PI / 2;
        xCoordinateForArrow = ARROW_HEIGHT;// + 1;
        yCoordinateForArrow = CGRectGetMidY(self.layer.bounds) + self.arrowOffset;
        shadowOffset = CGSizeMake(ARROW_HEIGHT, 0);
    }

    
    CGSize layerSize = self.layer.bounds.size;
    CGPoint layerPosition = self.layer.position;
    
    self.backgroundLayer.bounds = CGRectSetSize(self.layer.bounds, CGSizeMake(layerSize.width +widthModification, layerSize.height + heightModification));
    self.backgroundLayer.position = CGPointMake(layerPosition.x + xModification, layerPosition.y + yModification);
    
    self.arrowLayer.position = CGPointMake(xCoordinateForArrow, yCoordinateForArrow);
    self.arrowLayer.transform = CATransform3DMakeRotation(rotationForArrow, 0, 0, 1);
    self.layer.shadowOffset = shadowOffset;
}

-(UIColor *)borderColor{
    return [UIColor whiteColor];
}

-(BOOL)hasShadow{
    return YES;
}

+(CGFloat)borderWidth{
    return 10.0f;
}

//-(void)layoutSubviews
//{
//    if (self.arrowDirection == UIPopoverArrowDirectionUp)
//    {
//        CGFloat height = [[self class] arrowHeight];
//        CGFloat base = [[self class] arrowBase];
//        
//        self.background.frame = CGRectMake(0, height, self.frame.size.width, self.frame.size.height - height);
//        
//        self.arrow.frame = CGRectMake(self.frame.size.width * 0.5 + self.arrowOffset - base * 0.5, 1.0, base, height);
//        [self bringSubviewToFront:self.arrow];
//        
//    }
//}


@end

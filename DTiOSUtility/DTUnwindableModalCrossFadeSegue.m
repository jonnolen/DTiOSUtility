//
//  PBFadeAndSlide.m
//  PassagewaysBoard
//
//  Created by Jonathan Nolen on 10/4/12.
//  Copyright (c) 2012 Passageways. All rights reserved.
//

#import "DTUnwindableModalCrossFadeSegue.h"
#import "UIView+DTUtility.h"
#import <UIKit/UIKit.h>

@implementation DTUnwindableModalCrossFadeSegue

-(void)perform{
    UIView *sourceView = [[self sourceViewController] view];
    UIView *destinationView = [[self destinationViewController] view];

    UIImageView *sourceImageView;
    sourceImageView = [[UIImageView alloc]
                       initWithImage:[sourceView viewSnapshot]];
    
    CGRect originalFrame = destinationView.bounds;
    
    UIImageView *destinationImageView;
    destinationImageView = [[UIImageView alloc]
                            initWithImage:[destinationView viewSnapshot]];
    
    destinationImageView.frame = originalFrame;
    destinationImageView.alpha = 0.0;
    
    [self.destinationViewController setModalPresentationStyle:UIModalPresentationCurrentContext];
    [self.sourceViewController presentViewController:self.destinationViewController animated:NO completion:nil];
    
    [destinationView addSubview:sourceImageView];
    [destinationView addSubview:destinationImageView];
    
    void (^animations)(void) = ^ {
        [sourceImageView setAlpha:0];
        [destinationImageView setAlpha:1.0];
        
    };
    
    void (^completion)(BOOL) = ^(BOOL finished) {
        if (finished) {
            
            destinationView.hidden = NO;
            [sourceImageView removeFromSuperview];
            [destinationImageView removeFromSuperview];
            
        }
    };
    
    [UIView animateWithDuration:.5 delay:.0 options:UIViewAnimationOptionCurveEaseOut animations:animations completion:completion];
}

-(void)unwind{
    UIView *sourceView = [[self destinationViewController] view];
    UIView *destinationView = [[self sourceViewController] view];
    
    UIImageView *sourceImageView;
    sourceImageView = [[UIImageView alloc]
                       initWithImage:[sourceView viewSnapshot]];
    
    CGRect originalFrame = destinationView.bounds;
    
    UIImageView *destinationImageView;
    destinationImageView = [[UIImageView alloc]
                            initWithImage:[destinationView viewSnapshot]];
    
    destinationImageView.frame = originalFrame;
    destinationImageView.alpha = 0.0;
    
    [self.destinationViewController dismissViewControllerAnimated:NO completion:nil];
    
    [destinationView addSubview:sourceImageView];
    [destinationView addSubview:destinationImageView];
    
    void (^animations)(void) = ^ {
        [sourceImageView setAlpha:0];
        [destinationImageView setAlpha:1.0];
        
    };
    
    void (^completion)(BOOL) = ^(BOOL finished) {
        if (finished) {
            
            destinationView.hidden = NO;
            [sourceImageView removeFromSuperview];
            [destinationImageView removeFromSuperview];
            
        }
    };
    
    [UIView animateWithDuration:.5
                          delay:.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:animations completion:completion];
}

@end

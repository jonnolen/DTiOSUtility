//
//  PBUnwindableViewController.h
//  PassagewaysBoard
//
//  Created by Jonathan Nolen on 10/4/12.
//  Copyright (c) 2012 Passageways. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DTUnwindableSegue.h"

@protocol DTUnwindableViewController <NSObject>
@required
@property (nonatomic, strong) UIStoryboardSegue<DTUnwindableSegue> *unwindSegue;

-(void)unwind;

@end

//
//  PBUnwindableSegue.h
//  PassagewaysBoard
//
//  Created by Jonathan Nolen on 10/5/12.
//  Copyright (c) 2012 Passageways. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DTUnwindableSegue <NSObject>

@required
-(void)unwind;

@end

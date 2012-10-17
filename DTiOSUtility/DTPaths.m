//
//  PBPathHelper.m
//  PassagewaysBoard
//
//  Created by Jonathan Nolen on 9/26/12.
//  Copyright (c) 2012 Passageways. All rights reserved.
//

#import "DTPaths.h"

@implementation DTPaths

+(NSString *)Documents{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;

    return basePath;
}


@end

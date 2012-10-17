//
//  DTTestFlightWrapper.h
//  PassagewaysBoard
//
//  Created by Jonathan Nolen on 10/8/12.
//  Copyright (c) 2012 Passageways. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTTestFlightSDK : NSObject

+(void)configureWithTeamToken:(NSString *)token;
+(DTTestFlightSDK *)sharedSDK;

@end

//  DTTestFlightWrapper.h
//  Created by Jonathan Nolen on 10/8/12.

#import <Foundation/Foundation.h>

@interface DTTestFlightSDK : NSObject

+(void)configureWithTeamToken:(NSString *)token;
+(DTTestFlightSDK *)sharedSDK;

@end

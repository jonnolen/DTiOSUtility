//
//  DTTestFlightWrapper.m
//  PassagewaysBoard
//
//  Created by Jonathan Nolen on 10/8/12.
//  Copyright (c) 2012 Passageways. All rights reserved.
//

#import "DTTestFlightSDK.h"
#import <UIKit/UIKit.h>
#import <TestFlightSDK/TestFlight.h>

@interface DTTestFlightSDK()
-(id) initWithTestflightSDKTeamToken:(NSString *)token;
-(NSString *)deviceIdentifier;
-(void)takeFlight;
@property (nonatomic, readonly) NSString *teamToken;

@end

@implementation DTTestFlightSDK

static DTTestFlightSDK *_shared;

+(void)configureWithTeamToken:(NSString *)token{
    if(!_shared){
        _shared = [[self alloc] initWithTestflightSDKTeamToken:token];
        [_shared takeFlight];
    }
}

+(DTTestFlightSDK *)sharedSDK{
    if (!_shared){
        @throw [NSException exceptionWithName:@"ObjectNotConfigured"
                                       reason:@"Testflight SDK has not been configured yet.  Call [DTTestFlightSDK configureWithTeamToken:] before using."
                                     userInfo:nil];
    }
    return _shared;
}

@synthesize teamToken;
-(id)initWithTestflightSDKTeamToken:(NSString *)token{
    self = [super init];
    if (self){
        teamToken = token;
    }
    return self;
}
-(NSString *)deviceIdentifier{
    NSString *deviceId = nil;
    if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]){
        deviceId = [[[UIDevice currentDevice] performSelector:@selector(identifierForVendor)] performSelector:@selector(UUIDString)];
    }
    else{
#ifdef DEBUG
        #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        deviceId = [[UIDevice currentDevice] uniqueIdentifier];
        #pragma GCC diagnostic warning "-Wdeprecated-declarations"
#endif
    }
    
    return deviceId;
}

-(void)takeFlight{
#ifdef TESTFLIGHT
    [TestFlight setDeviceIdentifier:[_shared deviceIdentifier]];
    [TestFlight takeOff:_shared.teamToken];
#endif

    
}

@end

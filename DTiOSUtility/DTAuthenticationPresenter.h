//
//  DTAuthenticationPresenter.h
//  DTiOSUtility
//
//  Created by Jonathan Nolen on 9/24/13.
//  Copyright (c) 2013 Developertown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DTAuthenticationPresenterViewController <NSObject>
@property (nonatomic, readonly) BOOL isFinished;
@end

@interface DTAuthenticationPresenter : NSObject

+(instancetype)sharedAuthenticationPresenter;
+(void)setSharedAuthenticationPresenter:(DTAuthenticationPresenter *)presenter;

@property (nonatomic, strong) UIWindow *applicationWindow;
@property (nonatomic, copy) UIViewController<DTAuthenticationPresenterViewController> *(^authenticationViewControllerFactoryBlock)(void);
@property (nonatomic, assign) UIWindowLevel authenticationWindowLevel;

-(void)presentAuthentication;

@end


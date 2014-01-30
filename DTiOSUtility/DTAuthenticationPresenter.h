//  DTAuthenticationPresenter.h
//  Created by Jonathan Nolen on 9/24/13.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString *const DTAuthenticationPresenterFinishedAuthentication;

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


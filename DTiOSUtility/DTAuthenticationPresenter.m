//  DTAuthenticationPresenter.m
//  Created by Jonathan Nolen on 9/24/13.

#import "DTAuthenticationPresenter.h"
#import <libextobjc/EXTScope.h>

NSString *const DTAuthenticationPresenterStartedAuthentication = @"DTAuthenticationPresenterStartedAuthentication";
NSString *const DTAuthenticationPresenterFinishedAuthentication = @"DTAuthenticationPresenterFinishedAuthentication";
@interface DTAuthenticationPresenter(){
    UIWindow *presentedWindow;
    UIViewController<DTAuthenticationPresenterViewController> *authenticationViewController;
}

@end


@implementation DTAuthenticationPresenter
static DTAuthenticationPresenter *_sharedPresenter;

+(void)setSharedAuthenticationPresenter:(DTAuthenticationPresenter *)presenter{
    _sharedPresenter = presenter;
}

+(instancetype)sharedAuthenticationPresenter{
    if (!_sharedPresenter){
        _sharedPresenter = [self new];
    }
    return _sharedPresenter;
}

-(id)init{
    if (self = [super init]){
        _authenticationWindowLevel = UIWindowLevelNormal;
    }
    return self;
}

-(void)presentAuthentication{
    if (!presentedWindow && self.authenticationViewControllerFactoryBlock){
        presentedWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        authenticationViewController = self.authenticationViewControllerFactoryBlock();
        [authenticationViewController addObserver:self forKeyPath:@"isFinished" options:0 context:nil];
        presentedWindow.rootViewController = authenticationViewController;
        presentedWindow.windowLevel = self.authenticationWindowLevel;
        presentedWindow.alpha = 0.0;
        presentedWindow.hidden = NO;
        [presentedWindow makeKeyWindow];
        [UIView animateWithDuration:.25 animations:^{
            presentedWindow.alpha = 1.0;
        } completion:^(BOOL finished) {
            [[NSNotificationCenter defaultCenter] postNotificationName:DTAuthenticationPresenterStartedAuthentication object:self];
        }];
    }
    else{
        NSLog(@"Authentication already presented.");
        [presentedWindow makeKeyAndVisible];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (object == authenticationViewController && [keyPath isEqualToString:@"isFinished"]){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self clearAuthentication];
        });
    }
}

-(void)clearAuthentication{
    [[NSNotificationCenter defaultCenter] postNotificationName:DTAuthenticationPresenterFinishedAuthentication object:self];
    UIWindow *__strong strong_presentedWindow = presentedWindow;
    presentedWindow = nil;
    [authenticationViewController removeObserver:self forKeyPath:@"isFinished"];
    [authenticationViewController resignFirstResponder];
    authenticationViewController = nil;
    
    @weakify(self);
    [UIView animateWithDuration:.25
                     animations:^{
                         strong_presentedWindow.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         @strongify(self);
                         strong_presentedWindow.hidden = YES;
                         [strong_presentedWindow resignKeyWindow];
                         [self.applicationWindow makeKeyAndVisible];
                     }];
}

@end

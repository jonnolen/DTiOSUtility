//
//  DTAuthenticationPresenter.m
//  DTiOSUtility
//
//  Created by Jonathan Nolen on 9/24/13.
//  Copyright (c) 2013 Developertown. All rights reserved.
//

#import "DTAuthenticationPresenter.h"
#import <libextobjc/EXTScope.h>
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

-(void)presentAuthentication{
    if (!presentedWindow && self.authenticationViewControllerFactoryBlock){
        presentedWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        authenticationViewController = self.authenticationViewControllerFactoryBlock();
        [authenticationViewController addObserver:self forKeyPath:@"isFinished" options:0 context:nil];
        presentedWindow.rootViewController = authenticationViewController;
        presentedWindow.windowLevel = UIWindowLevelAlert;
        presentedWindow.alpha = 0.0;
        presentedWindow.hidden = NO;
        [presentedWindow makeKeyWindow];
        [UIView animateWithDuration:.25 animations:^{
            presentedWindow.alpha = 1.0;
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

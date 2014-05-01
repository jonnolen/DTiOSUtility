//  DTAuthenticationPresenter.m
//  Created by Jonathan Nolen on 9/24/13.

#import "DTAuthenticationPresenter.h"
#import <libextobjc/EXTScope.h>


NSString *const DTAuthenticationPresenterStartedAuthentication = @"DTAuthenticationPresenterStartedAuthentication";
NSString *const DTAuthenticationPresenterFinishedAuthentication = @"DTAuthenticationPresenterFinishedAuthentication";
@interface DTAuthenticationPresenter(){
    UIWindow *presentedWindow;
    UIViewController<DTAuthenticationPresenterViewController> *authenticationViewController;
    id didBecomeActiveObserver;
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
        _authenticationWindowLevel = [UIApplication sharedApplication].keyWindow.windowLevel + 0.1;
        didBecomeActiveObserver = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification
                                                                                    object:nil
                                                                                     queue:[NSOperationQueue mainQueue]
                                                                                usingBlock:^(NSNotification *n){
                                                                                    if (presentedWindow){
                                                                                        [presentedWindow makeKeyAndVisible];
                                                                                    }
                                                                                }];
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:didBecomeActiveObserver];
}

-(void)presentAuthenticationWithContext:(id)context animated:(BOOL)animated{
    if (!presentedWindow && self.hasFactoryBlock){
        presentedWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        if (self.authenticationViewControllerFactoryBlockWithContext) {
            authenticationViewController = self.authenticationViewControllerFactoryBlockWithContext(context);
        }
        else {
            authenticationViewController = self.authenticationViewControllerFactoryBlock();
        }
        
        [authenticationViewController addObserver:self forKeyPath:@"isFinished" options:0 context:nil];
        presentedWindow.rootViewController = authenticationViewController;
        presentedWindow.windowLevel = self.authenticationWindowLevel;

        presentedWindow.hidden = NO;
        [presentedWindow makeKeyWindow];
        if (animated){
            presentedWindow.alpha = 0.0;
            [UIView animateWithDuration:.25 animations:^{
                presentedWindow.alpha = 1.0;
            }];
        }
    }
    else{
        NSLog(@"Authentication already presented.");
        [presentedWindow makeKeyAndVisible];
    }
}
- (BOOL)hasFactoryBlock{
    return (self.authenticationViewControllerFactoryBlock || self.authenticationViewControllerFactoryBlockWithContext);
}
-(void)presentAuthentication:(BOOL)animated{
    [self presentAuthenticationWithContext:nil animated:animated];
}

-(void)presentAuthentication{
    [self presentAuthentication:YES];
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

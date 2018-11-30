//
//  JSProgressView.m
//  TestProject
//
//  Created by lmg on 2018/11/28.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "JSProgressView.h"
#import "MBProgressHUD.h"
#import "SVProgressHUD.h"
#import "JSProgressViewConfig.h"
#import <objc/runtime.h>


typedef NS_ENUM(NSInteger,JSProgressHUDType) {
    JSProgressHUDTypeSV    = 1,
    JSProgressHUDTypeMB
};

@interface JSProgressView ()

@end

@implementation JSProgressView

+ (void)showHUD
{
    [self setHudType:JSProgressHUDTypeSV];
    [self commitConfig:[self defaultConfig] hudView:nil];
    [SVProgressHUD show];
}

+ (void)showHUDWithDuration:(NSTimeInterval)duration
{
    [self showHUD];
    [self dismissWithDelay:duration];
}

+ (void)showWithImage:(UIImage *)image
{
    [self showWithImage:image status:nil];
}

+ (void)showWithImage:(UIImage *)image duration:(NSTimeInterval)duration
{
    [self showWithImage:image];
    [self dismissWithDelay:duration];
}

+ (void)showWithStatus:(NSString *)status
{
    [self showWithStatus:status duration:-1];
}

+ (void)showWithStatus:(NSString *)status duration:(NSTimeInterval)duration
{
    [self setHudType:JSProgressHUDTypeMB];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.frontWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    if (duration >= 0) {
        [hud hideAnimated:YES afterDelay:duration];
    }
    hud.label.text = status;
    [self commitConfig:[self defaultConfig] hudView:hud];
}


+ (void)showWithImage:(UIImage *)image status:(NSString *)status
{
    [self setHudType:JSProgressHUDTypeSV];
    [self commitConfig:[self defaultConfig] hudView:nil];
    [SVProgressHUD showImage:image status:status];
}

+(void)showWithImage:(UIImage *)image status:(NSString *)status duration:(NSTimeInterval)duration
{
    [self showWithImage:image status:status];
    [self dismissWithDelay:duration];
}

+ (void)showHUDWithStatus:(NSString *)status
{
    [self setHudType:JSProgressHUDTypeSV];
    [self commitConfig:[self defaultConfig] hudView:nil];
    [SVProgressHUD showWithStatus:status];
}

+ (void)showProgress:(CGFloat)progress
{
    [self showProgress:progress status:nil];
}

+ (void)showProgress:(CGFloat)progress status:(NSString *)status
{
    [SVProgressHUD showProgress:progress status:status];
}

+ (void)showHUDWithStatus:(NSString *)status duration:(NSTimeInterval)duration
{
    [self showHUDWithStatus:status];
    [self dismissWithDelay:duration];
}

+ (void)dismiss{
    [self dismissWithDelay:0 completion:nil];
}

+ (void)dismissWithDelay:(NSTimeInterval)delay{
    [self dismissWithDelay:delay completion:nil];
}

+ (void)setHudType:(JSProgressHUDType)type{
    objc_setAssociatedObject(self, @selector(setHudType:), @(type), OBJC_ASSOCIATION_ASSIGN);
}

+ (JSProgressHUDType)hudType{
    NSNumber *number = objc_getAssociatedObject(self, @selector(setHudType:));
    return (JSProgressHUDType)number.integerValue;
}

+ (void)dismissWithDelay:(NSTimeInterval)delay completion:(JSProgressViewDismissCompletion)completion
{
    JSProgressHUDType type = [self hudType];
    switch (type) {
        case JSProgressHUDTypeSV:
            [SVProgressHUD dismissWithDelay:delay completion:completion];
            break;
            
       case JSProgressHUDTypeMB:
           
            [MBProgressHUD hideHUDForView:self.frontWindow animated:YES];
            if (completion) {
                completion();
            }
            break;
    }
    
}

+ (void)cleanCustomConfig
{
    [self setCustomConfig:nil];
}

#pragma mark -runtime
+ (JSProgressViewConfig *)defaultConfig{
    return objc_getAssociatedObject(self, @selector(setCustomConfig:));
}

+ (void)setCustomConfig:(nullable JSProgressViewConfig *)customConfig
{
    objc_setAssociatedObject(self, @selector(setCustomConfig:), customConfig, OBJC_ASSOCIATION_RETAIN);
}



#pragma mark -Private Method
+ (void)commitConfig:(JSProgressViewConfig *)config hudView:(UIView *)hudView
{
    

    if (!config) {
        config = [JSProgressViewConfig defaultConfig];
    }
    
    JSProgressHUDType type = [self hudType];
    switch (type) {
        case JSProgressHUDTypeMB:
        {
            MBProgressHUD *hud = (MBProgressHUD *)hudView;
            hud.label.font = config.font;
            if (config.defaultMaskStyle == JSProgressHUDMaskStyleCustom) {
                hud.backgroundColor = config.backgroundLayerColor;
            }
            if (config.defaultMaskStyle == JSProgressHUDMaskStyleNone) {
                hud.userInteractionEnabled = NO;
            }
            hud.offset = CGPointMake(config.offsetFromCenter.horizontal, config.offsetFromCenter.vertical);
            hud.bezelView.backgroundColor = config.backgroundColor;
            hud.contentColor = config.foregroundColor;
        }
            break;
            
        case JSProgressHUDTypeSV:
        {
            [SVProgressHUD setMinimumSize:config.minSize];
            [SVProgressHUD setImageViewSize:config.imageViewSize];
            [SVProgressHUD setFont:config.font];
           
            [SVProgressHUD setRingRadius:config.ringRadius];
            [SVProgressHUD setCornerRadius:config.cornerRadius];
            [SVProgressHUD setRingThickness:config.ringThickness];
            [SVProgressHUD setRingNoTextRadius:config.ringNoTextRadius];
            [SVProgressHUD setShouldTintImages:config.shouldTintImages];
            [SVProgressHUD setOffsetFromCenter:config.offsetFromCenter];
            [SVProgressHUD setHapticsEnabled:config.hapticsEnabled];
            
            [SVProgressHUD setForegroundColor:config.foregroundColor];
            [SVProgressHUD setBackgroundColor:config.backgroundColor];
            [SVProgressHUD setBackgroundLayerColor:config.backgroundLayerColor];
            
            
            [SVProgressHUD setDefaultStyle:(SVProgressHUDStyle)config.defaultStyle];
            [SVProgressHUD setDefaultMaskType:(SVProgressHUDMaskType)config.defaultMaskStyle];
            [SVProgressHUD setDefaultAnimationType:(SVProgressHUDAnimationType)config.defaultAnimationStyle];
        }
            break;
    }
    
}

+ (UIWindow *)frontWindow {
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelSupported = (window.windowLevel >= UIWindowLevelNormal && window.windowLevel <= UIWindowLevelNormal);
        BOOL windowKeyWindow = window.isKeyWindow;
        
        if(windowOnMainScreen && windowIsVisible && windowLevelSupported && windowKeyWindow) {
            return window;
        }
    }
    return nil;
}

@end

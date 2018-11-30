//
//  JSProgressView.h
//  TestProject
//
//  Created by lmg on 2018/11/28.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^JSProgressViewDismissCompletion)(void);

typedef NS_ENUM(NSInteger,JSProgressBarType) {
    JSProgressBarTypeDeterminate,
    JSProgressBarTypeDeterminateHorizontalBar,
    JSProgressBarTypeAnnularDeterminate
};

@class MBProgressHUD,SVProgressHUD,JSProgressViewConfig;

@interface JSProgressView : NSObject

+ (void)showHUD;//纯动画
+ (void)showHUDWithDuration:(NSTimeInterval)duration;

+ (void)showWithStatus:(NSString *)status;//纯文字
+ (void)showWithStatus:(NSString *)status duration:(NSTimeInterval)duration;

+ (void)showWithImage:(UIImage *)image;//纯图片
+ (void)showWithImage:(UIImage *)image duration:(NSTimeInterval)duration;

+ (void)showProgress:(CGFloat)progress;//进度
+ (void)showProgress:(CGFloat)progress status:(nullable NSString*)status;

+ (void)showHUDWithStatus:(NSString *)status;//动画+文字
+ (void)showHUDWithStatus:(NSString *)status duration:(NSTimeInterval)duration;

+ (void)showWithImage:(UIImage *)image status:(nullable NSString *)status;//图片加文字
+ (void)showWithImage:(UIImage *)image status:(NSString *)status duration:(NSTimeInterval)duration;

+ (void)dismiss;
+ (void)dismissWithDelay:(NSTimeInterval)delay;
+ (void)dismissWithDelay:(NSTimeInterval)delay completion:(nullable JSProgressViewDismissCompletion)completion;

+ (void)setCustomConfig:(nullable JSProgressViewConfig *)customConfig;//[JSProgressViewConfig defaultConfig]
+ (void)cleanCustomConfig;//清除之前的所有自定义配置信息，并使用默认配置

@end

NS_ASSUME_NONNULL_END

//
//  JSProgressViewConfig.h
//  TestProject
//
//  Created by lmg on 2018/11/28.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,JSProgressHUDStyle) {
    JSProgressHUDStyleLight,
    JSProgressHUDStyleDark,
    JSProgressHUDStyleCustom
};

typedef NS_ENUM(NSUInteger,JSProgressHUDMaskStyle) {
    JSProgressHUDMaskStyleNone = 1,
    JSProgressHUDMaskStyleClear,
    JSProgressHUDMaskStyleBlack,
    JSProgressHUDMaskStyleGradient,
    JSProgressHUDMaskStyleCustom
};

typedef NS_ENUM(NSUInteger,JSProgressHUDAnimationStyle) {
    JSProgressHUDAnimationStyleFlat,
    JSProgressHUDAnimationStyleNative,
};

NS_ASSUME_NONNULL_BEGIN

@interface JSProgressViewConfig : NSObject

+ (instancetype)defaultConfig;

@property (nonatomic,assign) JSProgressHUDStyle defaultStyle;//JSProgressHUDStyleCustom
@property (nonatomic,assign) JSProgressHUDMaskStyle defaultMaskStyle;//JSProgressHUDMaskStyleNone
@property (nonatomic,assign) JSProgressHUDAnimationStyle defaultAnimationStyle;//JSProgressHUDAnimationStyleFlat


@property (nonatomic,assign) CGSize minSize;//CGSizeMake(80, 80);
@property (nonatomic,assign) CGSize imageViewSize;//28x28 pt
@property (nonatomic,assign) UIOffset offsetFromCenter;//is 0, 0

//JSProgressHUDAnimationStyleFlat时起作用
@property (nonatomic,assign) CGFloat ringThickness;//2 pt
@property (nonatomic,assign) CGFloat ringRadius;//18 pt
@property (nonatomic,assign) CGFloat ringNoTextRadius;//24 pt


@property (nonatomic,assign) CGFloat cornerRadius;//14 pt


@property (nonatomic,assign) BOOL shouldTintImages;//default is YES
@property (nonatomic,assign) BOOL hapticsEnabled;//default is NO
@property (nonatomic,strong) UIFont *font;//14


//JSProgressHUDStyleCustom
@property (nonatomic,strong) UIColor *foregroundColor;//[UIColor blackColor]
@property (nonatomic,strong) UIColor *backgroundColor;//[UIColor whiteColor]

//JSProgressHUDMaskStyleCustom时起作用
@property (nonatomic,strong) UIColor *backgroundLayerColor;//[UIColor colorWithWhite:0 alpha:0.4]

@end

NS_ASSUME_NONNULL_END

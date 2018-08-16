//
//  SVProgressHUD.h
//  Objective
//
//  Created by lmg on 2018/7/30.
//  Copyright © 2018年 we. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AvailabilityMacros.h>

extern NSString * _Nonnull const SVProgressHUDDidReceiveTouchEventNotification;
extern NSString * _Nonnull const SVProgressHUDDidTouchDownInsideNotification;
extern NSString * _Nonnull const SVProgressHUDWillDisappearNotification;
extern NSString * _Nonnull const SVProgressHUDDidDisappearNotification;
extern NSString * _Nonnull const SVProgressHUDWillAppearNotification;
extern NSString * _Nonnull const SVProgressHUDDidAppearNotification;

extern NSString * _Nonnull const SVProgressHUDStatusUserInfoKey;

typedef NS_ENUM(NSUInteger,SVProgressHUDStyle) {
    SVProgressHUDStyleLight,// default style, white HUD with black text, HUD background will be blurred
    SVProgressHUDStyleDark, // black HUD and white text, HUD background will be blurred
    SVProgressHUDStyleCustom// uses the fore- and background color properties
    
};

typedef NS_ENUM(NSUInteger,SVProgressHUDMaskType) {
    SVProgressHUDMaskTypeNone = 1,//default mask type, allow user interactions while HUD is displayed
    SVProgressHUDMaskTypeClear,// don't allow user interactions with background objects
    SVProgressHUDMaskTypeBlack,//don't allow user interactions with background objects and dim the UI in the back of the HUD (as seen in iOS 7 and above)
    SVProgressHUDMaskTypeGradient,//don't allow user interactions with background objects and dim the UI with a a-la UIAlertView background gradient (as seen in iOS 6)
    SVProgressHUDMaskTypeCustom// don't allow user interactions with background objects and dim the UI in the back of the HUD with a custom color
    
};

typedef NS_ENUM(NSUInteger,SVProgressHUDAnimationType) {
    
    SVProgressHUDAnimationTypeFlat,     // default animation type, custom flat animation (indefinite animated ring)
    SVProgressHUDAnimationTypeNative    // iOS native UIActivityIndicatorView
    
};

typedef void (^SVProgressHUDShowCompletion)(void);
typedef void (^SVProgressHUDDismissCompletion)(void);

@interface SVProgressHUD : UIView

@property (nonatomic,assign) SVProgressHUDStyle defaultStyle;// default is SVProgressHUDStyleLight
@property (nonatomic,assign) SVProgressHUDMaskType defaultMaskType;// default is SVProgressHUDMaskTypeNone
@property (nonatomic,assign) SVProgressHUDAnimationType defaultAnimationType;
@property (nonatomic,strong,nullable) UIView *containerView;// if nil then use default window level;
@property (nonatomic,strong,nonnull) UIView *viewForExtension;// default is nil, only used if #define SV_APP_EXTENSIONS is set
@property (nonatomic,strong,nonnull) UIColor *backgroundLayerColor;// default is [UIColor colorWithWhite:0 alpha:0.4]
@property (nonatomic,strong,nonnull) UIColor *backgroundColor;// default is [UIColor whiteColor]
@property (nonatomic,strong,nonnull) UIColor *foregroundColor;// default is [UIColor blackColor]
@property (nonatomic,strong) UIFont *font;// default is [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]
@property (nonatomic,assign) CGFloat cornerRadius;// default is 14 pt
@property (nonatomic,assign) CGSize imageViewSize;// default is 28x28 pt
@property (nonatomic,assign) CGFloat ringThickness;// default is 2 pt
@property (nonatomic,assign) CGFloat ringRadius;// default is 18 pt
@property (nonatomic,assign) CGFloat ringNoTextRadius;// default is 24 pt
@property (nonatomic,assign) CGSize minimumSize;// default is CGSizeZero, can be used to avoid resizing for a larger message
@property (nonatomic,assign) BOOL shouldTintImages;// default is YES
@property (nonatomic,assign) BOOL hapticsEnabled;// default is NO;
@property (nonatomic,strong,nonnull) UIImage *infoImage;// default is the bundled info image provided by Freepik
@property (nonatomic,strong,nonnull) UIImage *successImage;// default is the bundled success image provided by Freepik
@property (nonatomic,strong,nonnull) UIImage *errorImage;// default is the bundled error image provided by Freepik
@property (nonatomic,assign) NSTimeInterval graceTimeInterval;// default is 0 seconds
@property (nonatomic,assign) NSTimeInterval minimumDismissTimeInterval;// default is 5.0 seconds
@property (nonatomic,assign) NSTimeInterval maximumDismissTimeInterval;// default is CGFLOAT_MAX
@property (nonatomic,assign) NSTimeInterval fadeInAnimationDuration;// default is 0.15
@property (nonatomic,assign) NSTimeInterval fadeOutAnimationDuration;// default is 0.15
@property (nonatomic,assign) UIWindowLevel maxSupportedWindowLevel;//default is UIWindowLevelNormal
@property (assign, nonatomic) UIOffset offsetFromCenter UI_APPEARANCE_SELECTOR; // default is 0, 0



+ (void)setDefaultStyle:(SVProgressHUDStyle)style;                  // default is SVProgressHUDStyleLight
+ (void)setDefaultMaskType:(SVProgressHUDMaskType)maskType;         // default is SVProgressHUDMaskTypeNone
+ (void)setDefaultAnimationType:(SVProgressHUDAnimationType)type;   // default is SVProgressHUDAnimationTypeFlat



+ (void)setContainerView:(nullable UIView *)containerView;          // default is window level
+ (void)setMinimumSize:(CGSize)minimumSize;                         // default is CGSizeZero, can be used to avoid resizing for a larger message
+ (void)setRingThickness:(CGFloat)ringThickness;                    // default is 2 pt
+ (void)setRingRadius:(CGFloat)radius;                              // default is 18 pt
+ (void)setRingNoTextRadius:(CGFloat)radius;                        // default is 24 pt
+ (void)setCornerRadius:(CGFloat)cornerRadius;                      // default is 14 pt
+ (void)setBorderColor:(nonnull UIColor*)color;                     // default is nil
+ (void)setBorderWidth:(CGFloat)width;                              // default is 0
+ (void)setFont:(UIFont *)font;                                     // default is [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]
+ (void)setForegroundColor:(UIColor *)color;                        // default is [UIColor blackColor], only used for SVProgressHUDStyleCustom
+ (void)setBackgroundColor:(UIColor *)color;                        // default is [UIColor whiteColor], only used for SVProgressHUDStyleCustom
+ (void)setBackgroundLayerColor:(nonnull UIColor *)color;           // default is [UIColor colorWithWhite:0 alpha:0.5], only used for SVProgressHUDMaskTypeCustom
+ (void)setImageViewSize:(CGSize)size;                              // default is 28x28 pt
+ (void)setShouldTintImages:(BOOL)shouldTintImages;                 // default is YES
+ (void)setInfoImage:(nonnull UIImage *)image;                      // default is the bundled info image provided by Freepik
+ (void)setSuccessImage:(nonnull UIImage *)image;                   // default is the bundled success image provided by Freepik
+ (void)setErrorImage:(nonnull UIImage *)image;                     // default is the bundled error image provided by Freepik
+ (void)setViewForExtension:(nonnull UIView*)view;                  // default is nil, only used if #define SV_APP_EXTENSIONS is set
+ (void)setGraceTimeInterval:(NSTimeInterval)interval;              // default is 0 seconds
+ (void)setMinimumDismissTimeInterval:(NSTimeInterval)interval;     // default is 5.0 seconds
+ (void)setMaximumDismissTimeInterval:(NSTimeInterval)interval;     // default is infinite
+ (void)setFadeInAnimationDuration:(NSTimeInterval)duration;        // default is 0.15 seconds
+ (void)setFadeOutAnimationDuration:(NSTimeInterval)duration;       // default is 0.15 seconds
+ (void)setMaxSupportedWindowLevel:(UIWindowLevel)windowLevel;      // default is UIWindowLevelNormal
+ (void)setHapticsEnabled:(BOOL)hapticsEnabled;                        // default is NO

+ (void)setOffsetFromCenter:(UIOffset)offset;
+ (void)resetOffsetFromCenter;

#pragma mark - Show Methods
//show Message
+ (void)show;
+ (void)showWithStatus:(NSString *)status;
+ (void)showProgress:(float)progress;
+ (void)showProgress:(float)progress status:(nullable NSString *)status;
+ (void)setStatus:(nullable NSString *)status;

//show Image
+ (void)showInfoWithStatus:(nullable NSString *)status;
+ (void)showSuccessWithStatus:(nullable NSString *)status;
+ (void)showErrorWithStatus:(nullable NSString *)status;
+ (void)showImage:(nullable UIImage *)image status:(nullable NSString *)status;

+ (void)popActivity;  // decrease activity count, if activity count == 0 the HUD is dismissed
+ (void)dismiss;
+ (void)dismissWithCompletion:(nullable SVProgressHUDDismissCompletion)completion;
+ (void)dismissWithDelay:(NSTimeInterval)delay;
+ (void)dismissWithDelay:(NSTimeInterval)delay completion:(nullable SVProgressHUDDismissCompletion)completion;

+ (BOOL)isVisible;
+ (NSTimeInterval)displayDurationForString:(nullable NSString *)string;



@end

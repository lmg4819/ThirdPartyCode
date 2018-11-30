//
//  JSProgressViewConfig.m
//  TestProject
//
//  Created by lmg on 2018/11/28.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "JSProgressViewConfig.h"

@implementation JSProgressViewConfig

+ (instancetype)defaultConfig
{
    return [[self alloc]init];
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.minSize = CGSizeMake(80, 80);
        self.imageViewSize = CGSizeMake(28, 28);
        
        self.font = [UIFont systemFontOfSize:14];
       
        self.offsetFromCenter = UIOffsetMake(0, 0);
        
        self.ringRadius = 18;
        self.ringThickness = 2;
        self.ringNoTextRadius = 24;
        self.cornerRadius = 14;        
        
        self.shouldTintImages = YES;
        self.hapticsEnabled = NO;
        
        self.foregroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1.0];
        self.backgroundLayerColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        
        self.defaultStyle = JSProgressHUDStyleCustom;
        self.defaultMaskStyle = JSProgressHUDMaskStyleNone;
        self.defaultAnimationStyle = JSProgressHUDAnimationStyleFlat;
    }
    return self;
}

@end

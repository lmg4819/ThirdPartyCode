//
//  Shape.h
//  TestProject
//
//  Created by lmg on 2018/8/22.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,ShapeType) {
    ShapeTypeCircle,
    ShapeTypeRectangle,
    ShapeTypeSquare
};

@interface Shape : NSObject

+(instancetype)getShapeWithType:(ShapeType)type;

-(void)draw;

@end
/*
 
 简单工厂模式
 
 
 工厂模式:
 
 NSOperation
 
 NSBlockOperation
 NSInvocationOperation
 
 
 
 
 
 抽象工厂模式
 
 
 */

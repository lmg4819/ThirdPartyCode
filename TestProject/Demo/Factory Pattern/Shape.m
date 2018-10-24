//
//  Shape.m
//  TestProject
//
//  Created by lmg on 2018/8/22.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import "Shape.h"
#import "Circle.h"
#import "Rectangle.h"
#import "Square.h"

@implementation Shape

+(instancetype)getShapeWithType:(ShapeType)type
{
    switch (type) {
        case ShapeTypeCircle:
            return [Circle new];
            break;
        case ShapeTypeRectangle:
            return [Rectangle new];
            break;
        case ShapeTypeSquare:
            return [Square new];
            break;
    }
}

@end

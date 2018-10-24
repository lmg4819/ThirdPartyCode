//
//  FactoryProducerA.m
//  TestProject
//
//  Created by lmg on 2018/8/22.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import "FactoryProducerA.h"

@implementation FactoryProducerA
-(instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(UIColor *)getColor
{
    return [UIColor redColor];
}
-(NSString *)getShape
{
    return NSStringFromClass([self class]);
}


@end

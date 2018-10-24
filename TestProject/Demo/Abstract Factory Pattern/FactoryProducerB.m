//
//  FactoryProducerB.m
//  TestProject
//
//  Created by lmg on 2018/8/22.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import "FactoryProducerB.h"

@implementation FactoryProducerB
-(instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(UIColor *)getColor
{
    return [UIColor blackColor];
}
-(NSString *)getShape
{
    return NSStringFromClass([self class]);
}

@end

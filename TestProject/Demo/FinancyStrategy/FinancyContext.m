//
//  FinancyContext.m
//  TestProject
//
//  Created by lmg on 2018/8/27.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import "FinancyContext.h"

@implementation FinancyContext

- (instancetype)initWithFinancy:(id<FinancyStartegyProtocal>)financy
{
    self = [super init];
    if (self) {
        _financy = financy;
    }
    return self;
}

- (NSInteger)financyWithMonth:(NSInteger)month money:(NSInteger)money
{
    return [_financy financyWithMonth:month money:money];
}

@end

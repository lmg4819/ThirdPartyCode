//
//  AliPayFinancyStartegy.m
//  TestProject
//
//  Created by lmg on 2018/8/27.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import "AliPayFinancyStartegy.h"

@implementation AliPayFinancyStartegy

-(NSInteger)financyWithMonth:(NSInteger)month money:(NSInteger)money
{
    if (month <= 3) {
        return money * 0.07f / 12 * month + money;
    } else if (month <= 6) {
        return money * 0.08f / 12 * month + money;
    } else if (month <= 12) {
        return money * 0.095f / 12 * month + money;
    } else if (month <= 24) {
        return money * 0.105f / 12 * month + money;
    }
    return 0;
}

@end

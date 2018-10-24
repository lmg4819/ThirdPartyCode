//
//  YouLiFinancyStrategy.m
//  TestProject
//
//  Created by lmg on 2018/8/27.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import "YouLiFinancyStrategy.h"

@implementation YouLiFinancyStrategy

- (NSInteger)financyWithMonth:(NSInteger)month money:(NSInteger)money
{
    if (month <= 6) {
        return money * 0.03f / 12 * month + money;
    } else if (month <= 12) {
        return money * 0.04f / 12 * month + money;
    } else if (month <= 24) {
        return money * 0.045f / 12 * month + money;
    }
    return 0;
}


@end

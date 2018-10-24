//
//  FinancyContext.h
//  TestProject
//
//  Created by lmg on 2018/8/27.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FinancyStartegyProtocal.h"

@interface FinancyContext : NSObject

@property (nonatomic,weak) id<FinancyStartegyProtocal>financy;

- (instancetype)initWithFinancy:(id<FinancyStartegyProtocal>)financy;

- (NSInteger)financyWithMonth:(NSInteger)month money:(NSInteger)money;


@end

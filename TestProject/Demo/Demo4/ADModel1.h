//
//  ADModel1.h
//  TestProject
//
//  Created by lmg on 2018/8/22.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADAdapterProticol.h"

@interface ADModel1 : NSObject<ADAdapterProticol>
@property (nonatomic,copy) NSString *adImageName;
@property (nonatomic,copy) NSString *adUserName;
@property (nonatomic,copy) NSString *adDataTimeStr;
@end

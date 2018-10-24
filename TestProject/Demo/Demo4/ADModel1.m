//
//  ADModel1.m
//  TestProject
//
//  Created by lmg on 2018/8/22.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import "ADModel1.h"

@implementation ADModel1
-(UIImage *)image
{
    return [UIImage imageNamed:self.adImageName];
}

-(NSString *)text
{
    return self.adUserName;
}
-(NSString *)detailText
{
    return self.adDataTimeStr;
}
@end

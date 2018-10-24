//
//  ADModel.m
//  TestProject
//
//  Created by lmg on 2018/8/22.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import "ADModel.h"

@implementation ADModel
-(UIImage *)image
{
    return [UIImage imageNamed:self.imageName];
}

-(NSString *)text
{
    return self.userName;
}
-(NSString *)detailText
{
    return self.dateTimeStr;
}
@end

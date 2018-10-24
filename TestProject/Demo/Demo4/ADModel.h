//
//  ADModel.h
//  TestProject
//
//  Created by lmg on 2018/8/22.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADAdapterProticol.h"

@interface ADModel : NSObject<ADAdapterProticol>

@property (nonatomic,copy) NSString *imageName;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *dateTimeStr;


@end

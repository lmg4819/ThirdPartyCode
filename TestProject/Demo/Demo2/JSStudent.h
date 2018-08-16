//
//  JSStudent.h
//  TestProject
//
//  Created by lmg on 2018/8/8.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NSObject+YYModel.h>

@class JSScore;

@interface JSStudent : NSObject<YYModel>
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *gender;
@property (nonatomic,copy) NSString *userId;
@property (nonatomic,strong) NSArray<JSScore *> *scores;
@end

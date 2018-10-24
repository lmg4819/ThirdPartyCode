//
//  MGMSNetworkTool.h
//  TestProject
//
//  Created by lmg on 2018/8/28.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AFSuccessBlcok)(id responseObject);
typedef void(^AFFailBlock)(NSError *error);


@interface MGMSNetworkTool : NSObject

+(void)requestGarageInfoWithProductName:(NSString *)productName andEvaluationNO:(NSString *)evaluationNO  successBlock:(AFSuccessBlcok)successBlcok failBlcok:(AFFailBlock)failBlcok;

@end

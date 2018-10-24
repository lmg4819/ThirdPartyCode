//
//  MGMSNetworkTool.m
//  TestProject
//
//  Created by lmg on 2018/8/28.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import "MGMSNetworkTool.h"
#import "AFNetworking.h"


//
@implementation MGMSNetworkTool

+(void)requestGarageInfoWithProductName:(NSString *)productName andEvaluationNO:(NSString *)evaluationNO successBlock:(AFSuccessBlcok)successBlcok failBlcok:(AFFailBlock)failBlcok
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", nil];
    NSDictionary *dict = @{
                           @"EvaluationNo":evaluationNO,
                           @"ReportCode":productName,
                           };
    NSString *urlStr = @"http://open268v.vip.test.suixinhuan.com/api/CarData/EvaluationDetail";
    [manager POST:urlStr parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        NSString *msg = responseObject[@"msg"];
        if (code == 0) {
            if (successBlcok) {
                successBlcok(responseObject);
            }
        }else
        {
            NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:code     userInfo:@{@"description":msg}];
            if (failBlcok) {
                failBlcok(error);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failBlcok) {
            failBlcok(error);
        }
    }];
    
}


@end

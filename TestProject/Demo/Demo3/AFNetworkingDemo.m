//
//  AFNetworkingDemo.m
//  TestProject
//
//  Created by lmg on 2018/8/13.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import "AFNetworkingDemo.h"
#import "AFNetworking.h"
#import "JSNetworking.h"


@implementation AFNetworkingDemo


//http://i.test.268v.com/small/c/1805/17/20180517093434-hxpjq4wee5k.jpg?w=500
+(void)downloadImage
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://i.test.268v.com/small/c/1805/17/20180517093434-hxpjq4wee5k.jpg?w=500"] cachePolicy:0 timeoutInterval:60];

    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%f",downloadProgress.fractionCompleted);
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        UIImage *image = [UIImage imageWithData:responseObject];
        NSLog(@"---=%@=---",image);
    }];
    [dataTask resume];
    
//    NSURLSessionDownloadTask *downloadTask =  [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//        NSLog(@"%f",downloadProgress.fractionCompleted);
//    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//        NSString *destination = [cachePath stringByAppendingPathComponent:response.suggestedFilename];
//        return [NSURL URLWithString:destination];
//    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//        UIImage *image = [UIImage imageWithContentsOfFile:filePath.absoluteString];
//                if (error) {
//                    NSLog(@"下载失败----%@",error.description);
//                }else
//                {
//                    NSLog(@"下载成功");
//                }
//    }];
//    [downloadTask resume];

//    JSNetworking *manager = [JSNetworking sharedInstance];
//    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://i.test.268v.com/small/c/1805/17/20180517093434-hxpjq4wee5k.jpg?w=500"]];
//   NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
//        NSLog(@"%f",downloadProgress.fractionCompleted);
//    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//        NSString *destination = [cachePath stringByAppendingPathComponent:response.suggestedFilename];
//        return [NSURL URLWithString:destination];
//    } completionHandler:^(NSURLResponse *response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"下载失败----%@",error.description);
//        }else
//        {
//            NSLog(@"下载成功");
//        }
//    }];
//    [downloadTask resume];
}
+(void)requestGarageInfo:(NSString *)productCode andEvaluationNo:(NSString *)EvaluationNo successData:(SuccessBlock)successData FaillError:(FailBlock)FaillData
{
    NSString * allUrlStr = @"https://mapitest.cheyipai.com/Api/JGBDetail/EvaluationDetail";

    JSNetworking *manager = [JSNetworking sharedInstance];


    NSDictionary *params = @{@"fromType":@"ios",
                             @"version":@"1.4.3",
                             @"businessid":@"147910",
                             @"onlineid":@"d7c534e4-0c26-4d34-98d8-efbf0bc94a9d",
                             @"EvaluationNo":EvaluationNo,
                             @"ReportCode":productCode,
                             @"userId":@"147910",
                             @"sessionId":@"6159282c-95b5-4c5d-a3a1-df69e656d236",
                             @"username":@"jgb1",
                             @"sig":@"3c39aa53938f91a9cf369600070e0c80",
                             @"memberCode":@"US033635",
                             @"shopMemberCode":@"US033635",
                             @"memberTel":@"13716459804"};

    NSDictionary *headers = @{@"p":@"4",@"ip":@"fe80::e49d:fadc:ba36:4ed4",@"memberTel":@"13716459804",@"tid":@"FDE9D5AD-9849-4A73-96F0-9CF6818E99BC1533533996558",@"clienttype":@"1",@"Accept-Encoding":@"gzip",@"dn":@"iPhone",@"sv":@"11.4",@"e":@"0",@"s":@"AppStore",@"pm":@"iPhone 6 Plus",@"imei":@"FDE9D5AD-9849-4A73-96F0-9CF6818E99BC",@"businessid":@"147910",@"shopMemberCode":@"US033635",@"version":@"1.4.3",@"os":@"iOS",@"onlineid":@"d7c534e4-0c26-4d34-98d8-efbf0bc94a9d",@"ll":@"116.406318,40.004957",@"ClientID":@"87e70b55e5af591769072bc216d840d9",@"memberCode":@"US033635",@"z":@"0",@"at":@"app",@"al":@"",@"n":@"2",@"sc":@"414*736",@"ow":@"0",@"app":@"80",@"username":@"jgb1"};

    [manager.urlRequest setAllHTTPHeaderFields:headers];
    
    CFTimeInterval startTime = CFAbsoluteTimeGetCurrent();
    
    [manager requestMethod:JSNetworkingRequestMethodPOST urlString:allUrlStr parameters:params uploadProgress:nil downloadProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                NSInteger resultCode = [responseObject[@"code"] integerValue];
                NSString *stateDescription = responseObject[@"msg"];
     CFTimeInterval endTime = CFAbsoluteTimeGetCurrent();
        NSLog(@"------%.6f--------",endTime-startTime);
                if (resultCode == 0) {

                    NSDictionary *dic = responseObject[@"data"];

                    if(successData)
                        successData(dic,resultCode,stateDescription);

                } else {
                    if(successData)
                        successData(nil,resultCode,stateDescription);
                }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                if(FaillData)
                    FaillData(error.description);
        CFTimeInterval endTime = CFAbsoluteTimeGetCurrent();
        NSLog(@"------%.6f--------",endTime-startTime);
    }];

}
//+(void)requestGarageInfo:(NSString *)productCode andEvaluationNo:(NSString *)EvaluationNo successData:(SuccessBlock)successData FaillError:(FailBlock)FaillData
//{
//    NSString * allUrlStr = @"https://mapitest.cheyipai.com/Api/JGBDetail/EvaluationDetail";
//    NSString *baseURL = @"https://mapitest.cheyipai.com/Api/";
//    NSString *urlString = @"JGBDetail/EvaluationDetail";
//
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:baseURL]];
//    manager.requestSerializer.timeoutInterval = 60;
//    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
//    manager.operationQueue.maxConcurrentOperationCount = -1;
//
//
//    NSDictionary *params = @{@"fromType":@"ios",
//                             @"version":@"1.4.3",
//                             @"businessid":@"147910",
//                             @"onlineid":@"d7c534e4-0c26-4d34-98d8-efbf0bc94a9d",
//                             @"EvaluationNo":EvaluationNo,
//                             @"ReportCode":productCode,
//                             @"userId":@"147910",
//                             @"sessionId":@"6159282c-95b5-4c5d-a3a1-df69e656d236",
//                             @"username":@"jgb1",
//                             @"sig":@"3c39aa53938f91a9cf369600070e0c80",
//                             @"memberCode":@"US033635",
//                             @"shopMemberCode":@"US033635",
//                             @"memberTel":@"13716459804"};
//
//    NSDictionary *headers = @{@"p":@"4",@"ip":@"fe80::e49d:fadc:ba36:4ed4",@"memberTel":@"13716459804",@"tid":@"FDE9D5AD-9849-4A73-96F0-9CF6818E99BC1533533996558",@"clienttype":@"1",@"Accept-Encoding":@"gzip",@"dn":@"iPhone",@"sv":@"11.4",@"e":@"0",@"s":@"AppStore",@"pm":@"iPhone 6 Plus",@"imei":@"FDE9D5AD-9849-4A73-96F0-9CF6818E99BC",@"businessid":@"147910",@"shopMemberCode":@"US033635",@"version":@"1.4.3",@"os":@"iOS",@"onlineid":@"d7c534e4-0c26-4d34-98d8-efbf0bc94a9d",@"ll":@"116.406318,40.004957",@"ClientID":@"87e70b55e5af591769072bc216d840d9",@"memberCode":@"US033635",@"z":@"0",@"at":@"app",@"al":@"",@"n":@"2",@"sc":@"414*736",@"ow":@"0",@"app":@"80",@"username":@"jgb1"};
//
//    NSMutableURLRequest * request =
//    [manager.requestSerializer requestWithMethod:@"POST"
//                                       URLString:allUrlStr
//                                      parameters:params
//                                           error:nil];
//    [request setAllHTTPHeaderFields:headers];
//CFTimeInterval startTime = CFAbsoluteTimeGetCurrent();
//    [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSInteger resultCode = [responseObject[@"code"] integerValue];
//        NSString *stateDescription = responseObject[@"msg"];
//        CFTimeInterval endTime = CFAbsoluteTimeGetCurrent();
//    NSLog(@"------%.6f--------",endTime-startTime);
//        if (resultCode == 0) {
//
//
//            NSDictionary *dic = responseObject[@"data"];
//
//            if(successData)
//                successData(dic,resultCode,stateDescription);
//
//        } else {
//            if(successData)
//                successData(nil,resultCode,stateDescription);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                if(FaillData)
//                    FaillData(error.description);
//        CFTimeInterval endTime = CFAbsoluteTimeGetCurrent();
//        NSLog(@"------%.6f--------",endTime-startTime);
//    }];
//
//}
@end

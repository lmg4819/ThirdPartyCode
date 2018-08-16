//
//  AFNetworkingDemo.h
//  TestProject
//
//  Created by lmg on 2018/8/13.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessBlock)(id model, NSInteger resultCode, NSString* stateDescription);
typedef void (^FailBlock)(NSString *errorStr);

@interface AFNetworkingDemo : NSObject
+(void)requestGarageInfo:(NSString *)productCode andEvaluationNo:(NSString *)EvaluationNo successData:(SuccessBlock)successData FaillError:(FailBlock)FaillData;

+(void)downloadImage;
@end

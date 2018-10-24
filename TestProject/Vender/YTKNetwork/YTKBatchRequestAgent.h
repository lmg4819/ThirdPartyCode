//
//  YTKBatchRequestAgent.h
//  TestProject
//
//  Created by lmg on 2018/10/9.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class YTKBatchRequest;

@interface YTKBatchRequestAgent : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

+ (YTKBatchRequestAgent *)sharedAgent;

- (void)addBatchRequest:(YTKBatchRequest *)request;

- (void)removeBatchRequest:(YTKBatchRequest *)request;

@end

NS_ASSUME_NONNULL_END

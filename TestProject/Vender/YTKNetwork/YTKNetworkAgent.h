//
//  YTKNetworkAgent.h
//  TestProject
//
//  Created by lmg on 2018/9/30.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class YTKBaseRequest;

@interface YTKNetworkAgent : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

+ (YTKNetworkAgent *)sharedAgent;

- (void)addRequest:(YTKBaseRequest *)request;

- (void)cancelRequest:(YTKBaseRequest *)request;

- (void)cancelAllRequests;

- (NSString *)buildRequestUrl:(YTKBaseRequest *)request;


@end

NS_ASSUME_NONNULL_END

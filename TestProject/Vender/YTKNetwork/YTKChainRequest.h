//
//  YTKChainRequest.h
//  TestProject
//
//  Created by lmg on 2018/10/8.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class YTKChainRequest;
@class YTKBaseRequest;
@protocol YTKRequestAccessory;

@protocol YTKChainRequestDelegate <NSObject>

@optional

- (void)chainRequestFinished:(YTKChainRequest *)chainRequest;

- (void)chainRequestFailed:(YTKChainRequest *)chainRequest failedBaseRequest:(YTKBaseRequest *)request;

@end

typedef void(^YTKChainCallback)(YTKChainRequest *chainRequest,YTKBaseRequest *baseRequest);

@interface YTKChainRequest : NSObject

- (NSArray<YTKBaseRequest *>*)requestArray;

@property (nonatomic,weak,nullable) id<YTKChainRequestDelegate>delegate;

@property (nonatomic,strong,nullable) NSMutableArray<id<YTKRequestAccessory>> *requestAccessories;

- (void)addAccessory:(id<YTKRequestAccessory>)accessory;

- (void)start;

- (void)stop;

- (void)addRequest:(YTKBaseRequest *)request callback:(nullable YTKChainCallback)callback;

@end

NS_ASSUME_NONNULL_END

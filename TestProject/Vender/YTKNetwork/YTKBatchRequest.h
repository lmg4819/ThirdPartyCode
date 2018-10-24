//
//  YTKBatchRequest.h
//  TestProject
//
//  Created by lmg on 2018/10/8.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class YTKRequest;
@class YTKBatchRequest;
@protocol YTKRequestAccessory;

@protocol YTKBatchRequestDelegate <NSObject>

@optional

- (void)batchRequestFinished:(YTKBatchRequest *)request;

- (void)batchRequestFailed:(YTKBatchRequest *)request;

@end

@interface YTKBatchRequest : NSObject

//All the requests are stored in this array.
@property (nonatomic,strong,readonly) NSArray<YTKRequest *> *requestArray;

//The delegate object of the batch request. Default is nil.
@property (nonatomic,weak,nullable) id<YTKBatchRequestDelegate>delegate;

//The success callback. Note this will be called only if all the requests are finished.
@property (nonatomic,copy,nullable) void (^successCompletionBlock)(YTKBatchRequest *);

//The failure callback. Note this will be called if one of the requests fails.
@property (nonatomic,copy,nullable) void (^failureCompletionBlock)(YTKBatchRequest *);

//Tag can be used to identify batch request. Default value is 0.
@property (nonatomic) NSUInteger tag;

//This can be used to add several accossories object. Note if you use `addAccessory` to add acceesory
@property (nonatomic,strong,nullable) NSMutableArray<id<YTKRequestAccessory>> *requestAccessories;

//The first request that failed (and causing the batch request to fail).
@property (nonatomic,strong,readonly,nullable) YTKRequest *failedRequest;

- (instancetype)initWithRequestArray:(NSArray<YTKRequest *> *)requestArray;

- (void)setCompletionBlockWithSuccess:(nullable void(^)(YTKBatchRequest *batchRequest))success failure:(nullable void(^)(YTKBatchRequest *batchRequest))failure;

//Nil out both success and failure callback blocks.
- (void)clearCompletionBlock;

//Convenience method to add request accessory. See also `requestAccessories`.
- (void)addAccessory:(id<YTKRequestAccessory>)accessory;

- (void)start;

- (void)stop;

- (void)startWithCompletionBlockWithSuccess:(nullable void(^)(YTKBatchRequest *))success failure:(nullable void(^)(YTKBatchRequest *batchRequest))failure;

- (BOOL)isDataFromCache;


@end

NS_ASSUME_NONNULL_END

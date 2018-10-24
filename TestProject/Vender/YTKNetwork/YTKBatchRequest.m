//
//  YTKBatchRequest.m
//  TestProject
//
//  Created by lmg on 2018/10/8.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "YTKBatchRequest.h"
#import "YTKNetworkPrivate.h"
#import "YTKBatchRequestAgent.h"
#import "YTKRequest.h"

@interface YTKBatchRequest ()<YTKRequestDelegate>

@property (nonatomic) NSUInteger finishedCount;

@end

@implementation YTKBatchRequest

- (instancetype)initWithRequestArray:(NSArray<YTKRequest *> *)requestArray
{
    self = [super init];
    if (self) {
        _requestArray = [requestArray copy];
        _finishedCount = 0;
        for (YTKRequest *request in _requestArray) {
            if (![request isKindOfClass:[YTKRequest class]]) {
                YTKLog(@"Error, request item must be YTKRequest instance.");
                return nil;
            }
        }
    }
    return self;
}

- (void)start
{
    if (_finishedCount > 0) {
        YTKLog(@"Error! Batch request has already started.");
        return;
    }
    _failedRequest = nil;
    [[YTKBatchRequestAgent sharedAgent] addBatchRequest:self];
    [self toggleAccessoriesWillStartCallBack];
    for (YTKRequest *request in _requestArray) {
        request.delegate = self;
        [request clearCompletionBlock];
        [request start];
    }
}

- (void)stop
{
    [self toggleAccessoriesWillStopCallBack];
    _delegate = nil;
    [self clearRequest];
    [self toggleAccessoriesDidStopCallBack];
    [[YTKBatchRequestAgent sharedAgent] removeBatchRequest:self];
}

- (void)clearRequest {
    for (YTKRequest * req in _requestArray) {
        [req stop];
    }
    [self clearCompletionBlock];
}

- (void)clearCompletionBlock
{
    self.successCompletionBlock = nil;
    self.failureCompletionBlock = nil;
}

- (void)startWithCompletionBlockWithSuccess:(void (^)(YTKBatchRequest * _Nonnull))success failure:(void (^)(YTKBatchRequest * _Nonnull))failure
{
    [self setCompletionBlockWithSuccess:success failure:failure];
    [self start];
}

- (void)setCompletionBlockWithSuccess:(void (^)(YTKBatchRequest * _Nonnull))success failure:(void (^)(YTKBatchRequest * _Nonnull))failure
{
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
}

- (BOOL)isDataFromCache
{
    BOOL result = YES;
    for (YTKRequest *requset in _requestArray) {
        if (!requset.isDataFromCache) {
            result = NO;
        }
    }
    return result;
}

- (void)dealloc
{
    [self clearRequest];
}

#pragma mark -Network Request Delegate

- (void)requestFinished:(__kindof YTKRequest *)request
{
    _finishedCount++;
    if (_finishedCount == _requestArray.count) {
        [self toggleAccessoriesWillStopCallBack];
        if ([_delegate respondsToSelector:@selector(batchRequestFinished:)]) {
            [_delegate batchRequestFinished:self];
        }
        if (_successCompletionBlock) {
            _successCompletionBlock(self);
        }
        [self clearCompletionBlock];
        [self toggleAccessoriesDidStopCallBack];
        [[YTKBatchRequestAgent sharedAgent] removeBatchRequest:self];
    }
}

- (void)requestFailed:(__kindof YTKRequest *)request
{
    _failedRequest = request;
    [self toggleAccessoriesWillStopCallBack];
    
    for (YTKRequest *request in _requestArray) {
        [request stop];
    }
    
    if ([_delegate respondsToSelector:@selector(batchRequestFailed:)]) {
        [_delegate batchRequestFailed:self];
    }
    
    if (_failureCompletionBlock) {
        _failureCompletionBlock(self);
    }
    
    [self clearCompletionBlock];
    [self toggleAccessoriesDidStopCallBack];
    [[YTKBatchRequestAgent sharedAgent] removeBatchRequest:self];
}

#pragma mark -Request Accessoies
- (void)addAccessory:(id<YTKRequestAccessory>)accessory
{
    if (!self.requestAccessories) {
        self.requestAccessories = [NSMutableArray array];
    }
    [self.requestAccessories addObject:accessory];
}

@end

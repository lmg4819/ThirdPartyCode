//
//  YTKChainRequest.m
//  TestProject
//
//  Created by lmg on 2018/10/8.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "YTKChainRequest.h"
#import "YTKChainRequestAgent.h"
#import "YTKNetworkPrivate.h"
#import "YTKBaseRequest.h"

@interface YTKChainRequest ()<YTKRequestDelegate>

@property (nonatomic,strong) NSMutableArray<YTKBaseRequest *> *requestArray;
@property (nonatomic,strong) NSMutableArray<YTKChainCallback> *requestCallbackArray;
@property (nonatomic,assign) NSUInteger nextRequestIndex;
@property (nonatomic,strong) YTKChainCallback emptyCallback;

@end


@implementation YTKChainRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        _nextRequestIndex = 0;
        _requestArray = [NSMutableArray array];
        _requestCallbackArray = [NSMutableArray array];
        _emptyCallback = ^(YTKChainRequest *chainRequest, YTKBaseRequest *baseRequest) {
            // do nothing
        };
    }
    return self;
}

- (void)start
{
    if (_nextRequestIndex > 0) {
        YTKLog(@"Error! Chain request has already started.");
        return;
    }
    
    if ([_requestArray count] > 0) {
        [self toggleAccessoriesWillStartCallBack];
        [self startNextRequest];
        [[YTKChainRequestAgent sharedAgent] addChainRequest:self];
    }else
    {
        YTKLog(@"Error! Chain request array is empty.");
    }
    
}

- (void)stop
{
    [self toggleAccessoriesWillStopCallBack];
    [self clearRequest];
    [[YTKChainRequestAgent sharedAgent] removeChainRequest:self];
    [self toggleAccessoriesDidStopCallBack];
}

- (BOOL)startNextRequest
{
    if (_nextRequestIndex < [_requestArray count]) {
        YTKBaseRequest *request = _requestArray[_nextRequestIndex];
        _nextRequestIndex++;
        request.delegate = self;
        [request clearCompletionBlock];
        [request start];
        return YES;
    }else
    {
        return NO;
    }
}

- (void)clearRequest
{
    NSUInteger currentRequestIndex = _nextRequestIndex - 1;
    if (currentRequestIndex < [_requestArray count]) {
        YTKBaseRequest *request = _requestArray[currentRequestIndex];
        [request stop];
    }
    [_requestArray removeAllObjects];
    [_requestCallbackArray removeAllObjects];
}

- (void)addRequest:(YTKBaseRequest *)request callback:(YTKChainCallback)callback
{
    [_requestArray addObject:request];
    if (callback != nil) {
        [_requestCallbackArray addObject:callback];
    }else
    {
        [_requestCallbackArray addObject:_emptyCallback];
    }
}

- (NSArray<YTKBaseRequest *> *)requestArray
{
    return _requestArray;
}

- (void)addAccessory:(id<YTKRequestAccessory>)accessory
{
    if (!self.requestAccessories) {
        self.requestAccessories = [NSMutableArray array];
    }
    
    [self.requestAccessories addObject:accessory];
}

#pragma mark -YTKRequestDelegate

- (void)requestFinished:(__kindof YTKBaseRequest *)request
{
    NSUInteger currentRequestIndex = _nextRequestIndex - 1;
    YTKChainCallback callback = _requestCallbackArray[currentRequestIndex];
    callback(self,request);
    if (![self startNextRequest]) {
        [self toggleAccessoriesWillStopCallBack];
        if ([_delegate respondsToSelector:@selector(chainRequestFinished:)]) {
            [_delegate chainRequestFinished:self];
            [[YTKChainRequestAgent sharedAgent] removeChainRequest:self];
        }
        [self toggleAccessoriesDidStopCallBack];
    }
}

- (void)requestFailed:(__kindof YTKBaseRequest *)request
{
    [self toggleAccessoriesWillStopCallBack];
    if ([_delegate respondsToSelector:@selector(chainRequestFailed:failedBaseRequest:)]) {
        [_delegate chainRequestFailed:self failedBaseRequest:request];
        [[YTKChainRequestAgent sharedAgent] removeChainRequest:self];
    }
    [self toggleAccessoriesDidStopCallBack];
}

@end

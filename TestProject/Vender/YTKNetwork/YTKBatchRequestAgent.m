//
//  YTKBatchRequestAgent.m
//  TestProject
//
//  Created by lmg on 2018/10/9.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "YTKBatchRequestAgent.h"
#import "YTKBatchRequest.h"

@interface YTKBatchRequestAgent ()

@property (nonatomic,strong) NSMutableArray<YTKBatchRequest *> *requestArray;

@end

@implementation YTKBatchRequestAgent

+ (YTKBatchRequestAgent *)sharedAgent
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _requestArray = [NSMutableArray array];
    }
    return self;
}

- (void)addBatchRequest:(YTKBatchRequest *)request
{
    @synchronized (self) {
        [_requestArray addObject:request];
    }
}

- (void)removeBatchRequest:(YTKBatchRequest *)request
{
    @synchronized (self) {
        [_requestArray removeObject:request];
    }
}

@end

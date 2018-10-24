//
//  YTKChainRequestAgent.m
//  TestProject
//
//  Created by lmg on 2018/10/8.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "YTKChainRequestAgent.h"
#import "YTKChainRequest.h"

@interface YTKChainRequestAgent ()

@property (nonatomic,strong) NSMutableArray<YTKChainRequest *> *requestArray;

@end

@implementation YTKChainRequestAgent

+ (YTKChainRequestAgent *)sharedAgent
{
    static YTKChainRequestAgent *sharedInstance = nil;
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

-(void)addChainRequest:(YTKChainRequest *)request
{
    @synchronized (self) {
        [_requestArray addObject:request];
    }
}

-(void)removeChainRequest:(YTKChainRequest *)request
{
    @synchronized (self) {
        [_requestArray removeObject:request];
    }
}

@end

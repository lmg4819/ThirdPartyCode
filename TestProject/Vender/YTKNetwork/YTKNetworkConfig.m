//
//  YTKNetworkConfig.m
//  TestProject
//
//  Created by lmg on 2018/9/30.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "YTKNetworkConfig.h"
#import "YTKBaseRequest.h"

#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif


@implementation YTKNetworkConfig{
    NSMutableArray<id<YTKUrlFilterProtocol>> *_urlFilters;
    NSMutableArray<id<YTKCacheDirPathFilterProtocol>> *_cacheDirPathFilters;
}

+ (YTKNetworkConfig *)sharedConfig
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;
}


- (instancetype)init{
    self = [super init];
    if (self) {
        _baseUrl = @"";
        _cdnUrl = @"";
        _urlFilters = [NSMutableArray array];
        _cacheDirPathFilters = [NSMutableArray array];
        _securityPolicy = [AFSecurityPolicy defaultPolicy];
        _debugLogEnabled = NO;
    }
    return self;
}

- (void)addUrlFilter:(id<YTKUrlFilterProtocol>)filter
{
    [_urlFilters addObject:filter];
}

- (void)clearUrlFilter
{
    [_urlFilters removeAllObjects];
}

- (void)addCacheDirPathFilter:(id<YTKCacheDirPathFilterProtocol>)filter
{
    [_cacheDirPathFilters addObject:filter];
}

-(void)clearCacheDirPathFilter
{
    [_cacheDirPathFilters removeAllObjects];
}

-(NSArray<id<YTKUrlFilterProtocol>> *)urlFilters
{
    return [_urlFilters copy];
}

-(NSArray<id<YTKCacheDirPathFilterProtocol>> *)cacheDirPathFilters
{
    return [_cacheDirPathFilters copy];
}

#pragma mark -NSObject
-(NSString *)description
{
    return [NSString stringWithFormat:@"<%@:%p>{ baseURL: %@ } { cdnURL: %@}",NSStringFromClass([self class]),self,self.baseUrl,self.cdnUrl];
}


@end

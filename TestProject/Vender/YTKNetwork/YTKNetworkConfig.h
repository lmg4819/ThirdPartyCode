//
//  YTKNetworkConfig.h
//  TestProject
//
//  Created by lmg on 2018/9/30.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class YTKBaseRequest;
@class AFSecurityPolicy;

@protocol YTKUrlFilterProtocol <NSObject>

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request;

@end

@protocol YTKCacheDirPathFilterProtocol <NSObject>

- (NSString *)filterCacheDirPath:(NSString *)originalUrl withRequest:(YTKBaseRequest *)request;

@end

@interface YTKNetworkConfig : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

+ (YTKNetworkConfig *)sharedConfig;

@property (nonatomic,strong) NSString *baseUrl;
@property (nonatomic,strong) NSString *cdnUrl;

@property (nonatomic,strong,readonly) NSArray<id<YTKUrlFilterProtocol>> *urlFilters;
@property (nonatomic,strong,readonly) NSArray<id<YTKCacheDirPathFilterProtocol>> *cacheDirPathFilters;
@property (nonatomic,strong) AFSecurityPolicy *securityPolicy;
@property (nonatomic) BOOL debugLogEnabled;

@property (nonatomic,strong) NSURLSessionConfiguration *sessionConfiguration;

- (void)addUrlFilter:(id<YTKUrlFilterProtocol>)filter;
- (void)clearUrlFilter;

- (void)addCacheDirPathFilter:(id<YTKCacheDirPathFilterProtocol>)filter;
- (void)clearCacheDirPathFilter;


@end

NS_ASSUME_NONNULL_END

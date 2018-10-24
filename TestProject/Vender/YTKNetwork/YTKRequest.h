//
//  YTKRequest.h
//  TestProject
//
//  Created by lmg on 2018/9/30.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "YTKBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const YTKRequestCacheErrorDomain;

NS_ENUM(NSInteger){
    YTKRequestCacheErrorExpired = -1,
    YTKRequestCacheErrorVersionMismatch = -2,
    YTKRequestCacheErrorSensitiveDataMismatch = -3,
    YTKRequestCacheErrorAppVersionMismatch = -4,
    YTKRequestCacheErrorInvalidCacheTime = -5,
    YTKRequestCacheErrorInvalidMetadata = -6,
    YTKRequestCacheErrorInvalidCacheData = -7,
};

@interface YTKRequest : YTKBaseRequest

@property (nonatomic) BOOL ignoreCache;

//Whether data is from local cache.
- (BOOL)isDataFromCache;

//Manually load cache from storage.
- (BOOL)loadCacheWithError:(NSError * __autoreleasing *)error;

//Start request without reading local cache even if it exists. Use this to update local cache.
- (void)startWithoutCache;

//Save response data (probably from another request) to this request's cache location
- (void)saveResponseDataToCacheFile:(NSData *)data;

#pragma mark -Subclass Override

//The max time duration that cache can stay in disk until it's considered expired.
//  Default is -1, which means response is not actually saved as cache.
- (NSInteger)cacheTimeInSeconds;

//Version can be used to identify and invalidate local cache. Default is 0.
- (long long)cacheVersion;

//This can be used as additional identifier that tells the cache needs updating.
- (nullable id)cacheSensitiveData;

//Whether cache is asynchronously written to storage. Default is YES.
- (BOOL)writeCacheAsynchronously;

@end

NS_ASSUME_NONNULL_END

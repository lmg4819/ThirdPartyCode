//
//  YTKNetworkPrivate.h
//  TestProject
//
//  Created by lmg on 2018/9/30.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTKRequest.h"
#import "YTKBaseRequest.h"
#import "YTKBatchRequest.h"
#import "YTKChainRequest.h"
#import "YTKNetworkConfig.h"
#import "YTKNetworkAgent.h"


NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT void YTKLog(NSString *format, ...) NS_FORMAT_FUNCTION(1,2);

@class AFHTTPSessionManager;

@interface YTKNetworkUtils : NSObject

+ (BOOL)validateJSON:(id)json withValidator:(id)jsonValidator;

+ (void)addDoNotBackupAttribute:(NSString *)path;

+ (NSString *)md5StringFromString:(NSString *)string;

+ (NSString *)appVersionString;

+ (NSStringEncoding)stringEncodingWithRequest:(YTKBaseRequest *)request;

+ (BOOL)validateResumeData:(NSData *)data;

@end

@interface YTKRequest (Getter)

- (NSString *)cacheBasePath;

@end

@interface YTKBaseRequest (Setter)

@property (nonatomic,strong,readwrite) NSURLSessionTask *requestTask;
@property (nonatomic,strong,readwrite,nullable) NSData *responseData;
@property (nonatomic,strong,readwrite,nullable) id responseJSONObject;
@property (nonatomic,strong,readwrite,nullable) id responseObject;
@property (nonatomic,strong,readwrite,nullable) NSString *responseString;
@property (nonatomic,strong,readwrite,nullable) NSError *error;

@end

@interface YTKBaseRequest (RequestAccessory)

- (void)toggleAccessoriesWillStartCallBack;
- (void)toggleAccessoriesWillStopCallBack;
- (void)toggleAccessoriesDidStopCallBack;

@end

@interface YTKBatchRequest (RequestAccessory)

- (void)toggleAccessoriesWillStartCallBack;
- (void)toggleAccessoriesWillStopCallBack;
- (void)toggleAccessoriesDidStopCallBack;

@end

@interface YTKChainRequest (RequestAccessory)

- (void)toggleAccessoriesWillStartCallBack;
- (void)toggleAccessoriesWillStopCallBack;
- (void)toggleAccessoriesDidStopCallBack;

@end

@interface YTKNetworkAgent (Private)

- (AFHTTPSessionManager *)manager;
- (void)resetURLSessionManager;
- (void)resetURLSessionManagerWithConfiguration:(NSURLSessionConfiguration *)configuration;

- (NSString *)incompleteDownloadTempCacheFolder;



@end

NS_ASSUME_NONNULL_END

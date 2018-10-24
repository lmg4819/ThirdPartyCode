//
//  YTKBaseRequest.m
//  TestProject
//
//  Created by lmg on 2018/9/30.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "YTKBaseRequest.h"
#import "YTKNetworkAgent.h"
#import "YTKNetworkPrivate.h"

#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif

NSString *const YTKRequestValidationErrorDomain = @"com.yuantiku.request.validation";

@interface YTKBaseRequest ()
@property (nonatomic,strong,readwrite) NSURLSessionTask *requestTask;
@property (nonatomic,strong,readwrite) NSData *responseData;
@property (nonatomic,strong,readwrite) id responseJSONObject;
@property (nonatomic,strong,readwrite) id responseObject;
@property (nonatomic,strong,readwrite) NSString *responseString;
@property (nonatomic,strong,readwrite) NSError *error;

@end


@implementation YTKBaseRequest

#pragma mark -Request and Response Information

- (NSHTTPURLResponse *)response
{
    return (NSHTTPURLResponse *)self.requestTask.response;
}

- (NSInteger)responseStatusCode
{
    return self.response.statusCode;
}

- (NSDictionary *)responseHeaders
{
    return self.response.allHeaderFields;
}

- (NSURLRequest *)currentRequest
{
    return self.requestTask.currentRequest;
}

- (NSURLRequest *)originalRequest
{
    return self.requestTask.originalRequest;
}

- (BOOL)isCancelled
{
    if (!self.requestTask) {
        return NO;
    }
    return self.requestTask.state == NSURLSessionTaskStateCanceling;
}

- (BOOL)isExecuting
{
    if (!self.requestTask) {
        return NO;
    }
    return self.requestTask.state == NSURLSessionTaskStateRunning;
}

#pragma mark -Request Configuration
- (void)setCompletionBlockWithSuccess:(YTKRequestCompletionBlock)success
                              failure:(YTKRequestCompletionBlock)failure
{
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
}

- (void)clearCompletionBlock
{
    self.successCompletionBlock = nil;
    self.failureCompletionBlock = nil;
}

- (void)addAccessory:(id<YTKRequestAccessory>)accessory
{
    if (!self.requestAccessories) {
        self.requestAccessories = [NSMutableArray array];
    }
    [self.requestAccessories addObject:accessory];
}

#pragma mark -Request Action

- (void)start
{
    [self toggleAccessoriesWillStartCallBack];
    [[YTKNetworkAgent sharedAgent] addRequest:self];
}

- (void)stop
{
    [self toggleAccessoriesWillStopCallBack];
    self.delegate = nil;
    [[YTKNetworkAgent sharedAgent] cancelRequest:self];
    [self toggleAccessoriesDidStopCallBack];
}

- (void)startWithCompletionBlockWithSuccess:(YTKRequestCompletionBlock)success
                                   failure:(YTKRequestCompletionBlock)failure
{
    [self setCompletionBlockWithSuccess:success failure:failure];
    [self start];
}

#pragma mark -Subclass Override

- (void)requestCompletePreprocessor
{}

- (void)requestCompleteFilter
{}

- (void)requestFailedPreprocessor
{}

- (void)requestFailedFilter
{}

- (NSString *)requestUrl
{
    return @"";
}

- (NSString *)cdnUrl
{
    return @"";
}

- (NSString *)baseUrl
{
    return @"";
}

- (NSTimeInterval)requestTimeoutInterval
{
    return 60;
}

- (id)requestArgument
{
    return nil;
}

- (id)cacheFileNameFilterForRequestArgument:(id)argument
{
    return argument;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

- (YTKRequestSerializerType)requestSerializerType
{
    return YTKRequestSerializerTypeHTTP;
}

- (YTKResponseSerializerType)responseSerializerType
{
    return YTKResponseSerializerTypeJSON;
}

- (NSArray<NSString *> *)requestAuthorizationHeaderFieldArray
{
    return nil;
}

- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary
{
    return nil;
}

- (NSURLRequest *)buildCustomUrlRequest
{
    return nil;
}

- (BOOL)useCDN
{
    return NO;
}

- (BOOL)allowsCellularAccess
{
    return YES;
}

- (id)jsonValidator
{
    return nil;
}

- (BOOL)statusCodeValidator
{
    NSInteger statusCode = [self responseStatusCode];
    return (statusCode >= 200 && statusCode <= 299);
}

#pragma mark -NSObject

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p>{ URL: %@ } { Method: %@} {Arguments: %@}",NSStringFromClass([self class]),self,self.currentRequest.URL,self.currentRequest.HTTPMethod,self.requestArgument];
}

@end

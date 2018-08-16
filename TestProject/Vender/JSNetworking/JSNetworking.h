//
//  JSNetworking.h
//  TestProject
//
//  Created by lmg on 2018/8/14.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSSessionManagerTaskDelegate.h"
#import "JSMutableURLRequest.h"

@class JSMutableURLRequest;

typedef NS_ENUM(NSUInteger,JSNetworkingRequestMethod) {
    JSNetworkingRequestMethodGET,
    JSNetworkingRequestMethodPUT,
    JSNetworkingRequestMethodPOST,
    JSNetworkingRequestMethodHEAD,
    JSNetworkingRequestMethodPATCH,
    JSNetworkingRequestMethodDELETE
};



@interface JSNetworking : NSObject

@property (nonatomic,strong,readonly) JSMutableURLRequest *urlRequest;

/**
 Whether to attempt to retry creation of upload tasks for background sessions when initial call returns `nil`. `NO` by default.
 */
@property (nonatomic,assign) BOOL attemptsToRecreateUploadTasksForBackgroundSessions;

+ (instancetype)sharedInstance;


-(instancetype)initWithBaseURL:(NSURL *)baseURL Configuration:(NSURLSessionConfiguration *)configuration NS_DESIGNATED_INITIALIZER;

///---------------------------
/// @name Running Data Tasks
///---------------------------

- (NSURLSessionDataTask *)requestMethod:(JSNetworkingRequestMethod)requestMethod urlString:(NSString *)urlString parameters:(NSDictionary *)parameters uploadProgress:(AFURLSessionTaskProgressBlock)uplaodProgress downloadProgress:(AFURLSessionTaskProgressBlock)downloadProgress success:(void(^)(NSURLSessionDataTask *,id))success failure:(void(^)(NSURLSessionDataTask *,NSError *))failure;


///---------------------------
/// @name Running Upload Tasks
///---------------------------


- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request
                                         fromFile:(NSURL *)fileURL
                                         progress:(nullable void(^)(NSProgress *uploadProgress))uploadProgressBlock
                                completionHandler:(nullable void(^)(NSURLResponse *response,id _Nullable responseObject,NSError *_Nullable error))completionHandler;


- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request
                                         fromData:(nullable NSData *)bodyData
                                         progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgressBlock
                                completionHandler:(nullable void (^)(NSURLResponse *response, id _Nullable responseObject, NSError * _Nullable error))completionHandler;


- (NSURLSessionUploadTask *)uploadTaskWithStreamedRequest:(NSURLRequest *)request progress:(nullable void(^)(NSProgress *uploadProgress))uploadProgressBlock completionHandler:(nullable void(^)(NSURLResponse *response,id _Nullable responseObject,NSError *_Nullable error))completionHandler;


///-----------------------------
/// @name Running Download Tasks
///-----------------------------

- (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request
                                             progress:(nullable void(^)(NSProgress *downloadProgress))downloadProgressBlock
                                          destination:(nullable NSURL *(^)(NSURL *targetPath,NSURLResponse *response))destination
                                    completionHandler:(nullable void(^)(NSURLResponse *response,NSURL *_Nullable filePath,NSError *_Nullable error))completionHanlder;

- (NSURLSessionDownloadTask *)downloadTaskWithResumeData:(NSData *)resumeData
                                                progress:(void (^)(NSProgress * _Nonnull))downloadProgressBlock
                                             destination:(NSURL * _Nonnull (^)(NSURL * targetPath, NSURLResponse *response))destination
                                       completionHandler:(void (^)(NSURLResponse *response, NSURL *_Nullable filePath, NSError *_Nullable error))completionHanlder;


//-(NSMutableURLRequest *)requestConfiguration:(NSURL *)url withRequestMethod:(JSNetworkingRequestMethod)requestMethod parameters:(NSDictionary *)parameters;


@end

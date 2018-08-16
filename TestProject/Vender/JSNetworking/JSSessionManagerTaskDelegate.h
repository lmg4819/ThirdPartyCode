//
//  JSSessionManagerTaskDelegate.h
//  TestProject
//
//  Created by lmg on 2018/8/15.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^AFURLSessionTaskProgressBlock)(NSProgress *);
typedef void (^AFURLSessionTaskCompletionHandler)(NSURLResponse *response, id responseObject, NSError *error);
typedef NSURL * (^AFURLSessionDownloadTaskDidFinishDownloadingBlock)(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, NSURL *location);


@interface JSSessionManagerTaskDelegate : NSObject<NSURLSessionDataDelegate,NSURLSessionTaskDelegate,NSURLSessionDownloadDelegate>

- (instancetype)initWithTask:(NSURLSessionTask *)task;


@property (nonatomic, copy) AFURLSessionTaskProgressBlock uploadProgressBlock;
@property (nonatomic, copy) AFURLSessionTaskProgressBlock downloadProgressBlock;
@property (nonatomic, copy) AFURLSessionTaskCompletionHandler completionHandler;
@property (nonatomic,copy) AFURLSessionDownloadTaskDidFinishDownloadingBlock downloadTaskDidFinishDownloading;

@end

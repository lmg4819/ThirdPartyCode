//
//  JSSessionManagerTaskDelegate.m
//  TestProject
//
//  Created by lmg on 2018/8/15.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import "JSSessionManagerTaskDelegate.h"

static dispatch_group_t url_session_manager_completion_group() {
    static dispatch_group_t af_url_session_manager_completion_group;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        af_url_session_manager_completion_group = dispatch_group_create();
    });
    
    return af_url_session_manager_completion_group;
}

static dispatch_queue_t url_session_manager_processing_queue() {
    static dispatch_queue_t af_url_session_manager_processing_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        af_url_session_manager_processing_queue = dispatch_queue_create("com.alamofire.networking.session.manager.processing", DISPATCH_QUEUE_CONCURRENT);
    });
    
    return af_url_session_manager_processing_queue;
}

@interface JSSessionManagerTaskDelegate ()
@property (nonatomic, copy) NSURL *downloadFileURL;
@property (nonatomic,strong) NSMutableData *mutableData;
@property (nonatomic,strong) NSProgress *uploadProgress;
@property (nonatomic,strong) NSProgress *downloadProgress;
@end


@implementation JSSessionManagerTaskDelegate

-(instancetype)initWithTask:(NSURLSessionTask *)task
{
    self = [super init];
    if (self) {
        _mutableData = [NSMutableData data];
        _downloadProgress = [[NSProgress alloc]initWithParent:nil userInfo:nil];
        _uploadProgress = [[NSProgress alloc]initWithParent:nil userInfo:nil];
        for (NSProgress *progress in @[_downloadProgress,_uploadProgress]) {
            progress.totalUnitCount = NSURLSessionTransferSizeUnknown;
            [progress addObserver:self forKeyPath:NSStringFromSelector(@selector(fractionCompleted)) options:NSKeyValueObservingOptionNew context:NULL];
        }
    }
    return self;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([object isEqual:self.downloadProgress]) {
        if (self.downloadProgressBlock) {
            self.downloadProgressBlock(object);
        }
    }else if ([object isEqual:self.uploadProgress]){
        if (self.uploadProgressBlock) {
            self.uploadProgressBlock(object);
        }
    }
}
-(void)dealloc
{
    [self.downloadProgress removeObserver:self forKeyPath:NSStringFromSelector(@selector(fractionCompleted))];
    [self.uploadProgressBlock removeObserver:self forKeyPath:NSStringFromSelector(@selector(fractionCompleted))];
}
#pragma mark -NSURLSessionDataDelegate
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    self.downloadProgress.totalUnitCount = dataTask.countOfBytesExpectedToReceive;
    self.downloadProgress.completedUnitCount = dataTask.countOfBytesReceived;
    [self.mutableData appendData:data];
}


#pragma mark -NSURLSessionTaskDelegate
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    __block id responseObject = nil;
    NSData *data = nil;
    if (self.mutableData) {
        data = [self.mutableData copy];
        //We no longer need the reference, so nil it out to gain back some memory.
        self.mutableData = nil;
    }
    
    if (error) {
        dispatch_group_async(url_session_manager_completion_group(), dispatch_get_main_queue(), ^{
            if (self.completionHandler) {
                self.completionHandler(task.response, responseObject, error);
            }
        });
    }else
    {
        dispatch_async(url_session_manager_processing_queue(), ^{
            NSError *serializationError = nil;
            responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
            if (self.downloadFileURL) {
                responseObject = self.downloadFileURL;
            }
            
            dispatch_group_async(url_session_manager_completion_group(), dispatch_get_main_queue(), ^{
                if (self.completionHandler) {
                    self.completionHandler(task.response, responseObject, serializationError);
                }
            });
        });
    }
}

-(void)URLSession:(NSURLSession *)session
             task:(NSURLSessionTask *)task
  didSendBodyData:(int64_t)bytesSent
   totalBytesSent:(int64_t)totalBytesSent
totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    self.uploadProgress.totalUnitCount = task.countOfBytesExpectedToSend;
    self.uploadProgress.completedUnitCount = task.countOfBytesSent;
}

#pragma mark -NSURLSessionDownloadDelegate
-(void)URLSession:(NSURLSession *)session
     downloadTask:(NSURLSessionDownloadTask *)downloadTask
     didWriteData:(int64_t)bytesWritten
totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    self.downloadProgress.totalUnitCount = totalBytesExpectedToWrite;
    self.downloadProgress.completedUnitCount = totalBytesWritten;
}

-(void)URLSession:(NSURLSession *)session
     downloadTask:(NSURLSessionDownloadTask *)downloadTask
didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes
{
    self.downloadProgress.totalUnitCount = expectedTotalBytes;
    self.downloadProgress.completedUnitCount = fileOffset;
}
-(void)URLSession:(NSURLSession *)session
     downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    self.downloadFileURL = nil;
    if (self.downloadTaskDidFinishDownloading) {
        self.downloadFileURL = self.downloadTaskDidFinishDownloading(session,downloadTask,location);
        if (self.downloadFileURL) {
            NSError *fileManagerError = nil;
            if (![[NSFileManager defaultManager] moveItemAtURL:location toURL:self.downloadFileURL error:&fileManagerError]) {
                if (fileManagerError) {
                    NSLog(@"======%@",fileManagerError);
                }
            }
        }
        
    }
}
@end

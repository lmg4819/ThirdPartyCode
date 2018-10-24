//
//  YTKChainRequestAgent.h
//  TestProject
//
//  Created by lmg on 2018/10/8.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class YTKChainRequest;

///  YTKChainRequestAgent handles chain request management. It keeps track of all
///  the chain requests.
@interface YTKChainRequestAgent : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

///  Get the shared chain request agent.
+ (YTKChainRequestAgent *)sharedAgent;

///  Add a chain request.
- (void)addChainRequest:(YTKChainRequest *)request;

///  Remove a previously added chain request.
- (void)removeChainRequest:(YTKChainRequest *)request;

@end

NS_ASSUME_NONNULL_END

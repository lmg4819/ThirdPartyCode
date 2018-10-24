
//
//  YTKNetwork.h
//  TestProject
//
//  Created by lmg on 2018/10/9.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef YTKNetwork_h
#define YTKNetwork_h

#if __has_include(<YTKNetwork/YTKNetwork.h>)

FOUNDATION_EXPORT double YTKNetworkVersionNumber;
FOUNDATION_EXPORT const unsigned char YTKNetworkVersionString[];

#import <YTKNetwork/YTKRequest.h>
#import <YTKNetwork/YTKBaseRequest.h>
#import <YTKNetwork/YTKNetworkAgent.h>
#import <YTKNetwork/YTKBatchRequest.h>
#import <YTKNetwork/YTKBatchRequestAgent.h>
#import <YTKNetwork/YTKChainRequest.h>
#import <YTKNetwork/YTKChainRequestAgent.h>
#import <YTKNetwork/YTKNetworkConfig.h>

#else

#import "YTKRequest.h"
#import "YTKBaseRequest.h"
#import "YTKNetworkAgent.h"
#import "YTKBatchRequest.h"
#import "YTKBatchRequestAgent.h"
#import "YTKChainRequest.h"
#import "YTKChainRequestAgent.h"
#import "YTKNetworkConfig.h"

#endif

#endif /* YTKNetwork_h */

//
//  JSCombination.m
//  TestProject
//
//  Created by lmg on 2018/10/15.
//  Copyright © 2018 lmg. All rights reserved.
//

#import "JSCombination.h"
#import "JSCommonTool.h"

@interface JSCombination ()
@property (nonatomic,strong) JSCommonTool *commonTool;
@end

@implementation JSCombination

- (instancetype)init
{
    _commonTool = [JSCommonTool new];
    return self;
}

-(NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    NSMethodSignature *sig = [_commonTool methodSignatureForSelector:sel];
    return sig;
}

- (id)forwardingTargetForSelector:(SEL)selector {
   
    return _commonTool;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    if ([_commonTool respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:_commonTool];
    }
}

@end

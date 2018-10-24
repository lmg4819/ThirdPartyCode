//
//  Aspects.h
//  TestProject
//
//  Created by lmg on 2018/10/9.
//  Copyright © 2018 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, AspectOptions) {
    AspectPositionAfter = 0,//Called after the original implementation (default)
    AspectPositionInstead = 1,//Will replace the original implementation.
    AspectPositionBefore = 2,//Called before the original implementation.
    AspectPositionAutomaticRemoval = 1 << 3//Will remove the hook after the first execution.
    
};

//Opaque Aspect Token that allows to deregister the hook.
@protocol AspectToken <NSObject>

/// Deregisters an aspect.
/// @return YES if deregistration is successful, otherwise NO.
- (BOOL)remove;

@end

@protocol AspectInfo <NSObject>

//The instance that is currently hooked.
- (instancetype)instance;

//The original invocation of the hooked method.
- (NSInvocation *)originalInvocation;

//All method arguments, boxed. This is lazily evaluated.
- (NSArray *)arguments;

@end


/**
  Aspects uses Objective-C message forwarding to hook into messages. This will create some overhead. Don't add aspects to methods that are called a lot. Aspects is meant for view/controller code that is not called a 1000 times per second.
 
  Adding aspects returns an opaque token which can be used to deregister again. All calls are thread safe.
 */
@interface Aspects : NSObject

//Adds a block of code before/instead/after the current `selector` for a specific class.
+ (id<AspectToken>)aspect_hookSelector:(SEL)seletor
                           withOptions:(AspectOptions)options
                            usingBlock:(id)block
                                 error:(NSError **)error;

//Adds a block of code before/instead/after the current `selector` for a specific instance.
- (id<AspectToken>)aspect_hookSelector:(SEL)seletor
                           withOptions:(AspectOptions)options
                            usingBlock:(id)block
                                 error:(NSError **)error;


@end


typedef NS_ENUM(NSUInteger,AspectErrorCode) {
    
    AspectErrorSelectorBlackListed,//Selectors like release, retain, autorelease are blacklisted.
    AspectErrorDoesNotRespondToSelector,//Selector could not be found.
    AspectErrorSelectorDeallocPosition,//When hooking dealloc, only AspectPositionBefore is allowed.
    AspectErrorSelectorAlreadyHookedInClassHierarchy,//Statically hooking the same method in subclasses is not allowed.
    AspectErrorFailedToAllocateClassPair,//The runtime failed creating a class pair.
    AspectErrorMissingBlockSignature,//The block misses compile time signature info and can't be called.
    AspectErrorIncompatibleBlockSignature,//The block signature does not match the method or is too large.
    AspectErrorRemoveObjectAlreadyDeallocated = 100 //(for removing) The object hooked is already deallocated.
};

extern NSString *const AspectErrorDomain;

NS_ASSUME_NONNULL_END

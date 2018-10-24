////
////  Aspects.m
////  TestProject
////
////  Created by lmg on 2018/10/9.
////  Copyright © 2018 lmg. All rights reserved.
////
//
//#import "Aspects.h"
//#import <libkern/OSAtomic.h>
//#import <objc/runtime.h>
//#import <objc/message.h>
//
//#define AspectLog(...)
////#define AspectLog(...) do { NSLog(__VA_ARGS__); }while(0)
//#define AspectLogError(...) do { NSLog(__VA_ARGS__); }while(0)
//
//// Block internals.
//typedef NS_OPTIONS(int, AspectBlockFlags) {
//    AspectBlockFlagsHasCopyDisposeHelpers = (1<<25),
//    AspectBlockFlagsHasSignature          = (1<<30)
//};
//
//typedef struct _AspectBlock{
//    __unused Class isa;
//    AspectBlockFlags flags;
//    __unused int reserved;
//    void (__unused *invoke)(struct _AspectBlock *block, ...);
//    struct {
//        unsigned long int reserved;
//        unsigned long int size;
//        // requires AspectBlockFlagsHasCopyDisposeHelpers
//        void (*copy)(void *dst, const void *src);
//        void (*dispose)(const void *);
//        // requires AspectBlockFlagsHasSignature
//        const char *signature;
//        const char *layout;
//    } *descriptor;
//    // imported variables
//}*AspectBlockRef;
//
//@interface AspectInfo : NSObject<AspectInfo>
//
//- (id)initWithInstance:(__unsafe_unretained id)instance invocation:(NSInvocation *)invocation;
//
//@property (nonatomic,unsafe_unretained,readonly) id instance;
//@property (nonatomic,strong,readonly) NSArray *arguments;
//@property (nonatomic,strong,readonly) NSInvocation *originalInvocation;
//
//@end
//
//// Tracks a single aspect.
//@interface AspectIdentifier : NSObject
//+ (instancetype)identifierWithSelector:(SEL)selector object:(id)object options:(AspectOptions)options
//                                 block:(id)block error:(NSError **)error;
//- (BOOL)invokeWithInfo:(id<AspectInfo>)info;
//@property (nonatomic,assign) SEL selector;
//@property (nonatomic,strong) id block;
//@property (nonatomic,strong) NSMethodSignature *blockSignature;
//@property (nonatomic,weak) id object;
//@property (nonatomic,assign) AspectOptions options;
//@end
//
//// Tracks all aspects for an object/class.
//@interface AspectsContainer : NSObject
//- (void)addAspect:(AspectIdentifier *)aspect withOptions:(AspectOptions)injectPosition;
//- (void)removeAspect:(id)aspect;
//- (BOOL)hasAspects;
//@property (atomic,copy) NSArray *beforeAspects;
//@property (atomic,copy) NSArray *insteadAspects;
//@property (atomic,copy) NSArray *afterAspects;
//@end
//
//@interface AspectTracker : NSObject
//- (id)initWithTrackedClass:(Class)trackedClass parent:(AspectTracker *)parent;
//@property (nonatomic,strong) Class trackedClass;
//@property (nonatomic,strong) NSMutableSet *selectorNames;
//@property (nonatomic,weak) AspectTracker *parentEntry;
//@end
//
//@interface NSInvocation (Aspects)
//- (NSArray *)aspects_argument;
//@end
//
//#define AspectPositionFilter 0x07
//
//#define AspectError(errorCode, errorDescription) do { \
//AspectLogError(@"Aspects: %@", errorDescription); \
//if (error) { *error = [NSError errorWithDomain:AspectErrorDomain code:errorCode userInfo:@{NSLocalizedDescriptionKey: errorDescription}]; }}while(0)
//
//NSString *const AspectErrorDomain = @"AspectErrorDomain";
//static NSString *const AspectsSubclassSuffix = @"_Aspects_";
//static NSString *const AspectsMessagePrefix = @"aspects_";
//
//
//@implementation NSObject (Aspects)
//
//#pragma mark - Public Aspects API
//
//+ (id<AspectToken>)aspect_hookSelector:(SEL)seletor
//                           withOptions:(AspectOptions)options
//                            usingBlock:(id)block
//                                 error:(NSError **)error
//{
//    return nil;
//}
//
//- (id<AspectToken>)aspect_hookSelector:(SEL)seletor
//                           withOptions:(AspectOptions)options
//                            usingBlock:(id)block
//                                 error:(NSError **)error
//{
//    return nil;
//}
//
//#pragma mark -Private Helper
//
//static id aspect_add(id self,SEL selector,AspectOptions options,id block,NSError **error)
//{
//    NSCParameterAssert(self);
//    NSCParameterAssert(selector);
//    NSCParameterAssert(block);
//    
//    
//}
//
//@end
//
//
//@implementation Aspects
//
//@end

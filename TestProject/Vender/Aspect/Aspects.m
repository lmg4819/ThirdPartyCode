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
//    return aspect_add((id)self, seletor, options, block, error);
//}
//
//- (id<AspectToken>)aspect_hookSelector:(SEL)seletor
//                           withOptions:(AspectOptions)options
//                            usingBlock:(id)block
//                                 error:(NSError **)error
//{
//    return aspect_add(self, seletor, options, block, error);
//}
//
//#pragma mark -Private Helper
//
//static SEL aspect_aliasForSelector(SEL selector){
//    NSCParameterAssert(selector);
//    return NSSelectorFromString([AspectsMessagePrefix stringByAppendingFormat:@"_%@",NSStringFromSelector(selector)]);
//}
//
//// Loads or creates the aspect container.
//static AspectsContainer *aspect_getContainerForObject(NSObject *self,SEL selector){
//    NSCParameterAssert(self);
//    SEL aliasSelector = aspect_aliasForSelector(selector);
//    AspectsContainer *aspectContainer = objc_getAssociatedObject(self, aliasSelector);
//    if (!aspectContainer) {
//        aspectContainer = [AspectsContainer new];
//        objc_setAssociatedObject(self, aliasSelector, aspectContainer, OBJC_ASSOCIATION_RETAIN);
//    }
//    return aspectContainer;
//}
//
//static void _aspect_modifySwizzledClasses(void (^block)(NSMutableSet *swizzledClasses)) {
//    static NSMutableSet *swizzledClasses;
//    static dispatch_once_t pred;
//    dispatch_once(&pred, ^{
//        swizzledClasses = [NSMutableSet new];
//    });
//    @synchronized(swizzledClasses) {
//        block(swizzledClasses);
//    }
//}
//
//static void aspect_swizzleForwardInvocation(Class klass) {
//    NSCParameterAssert(klass);
//    // If there is no method, replace will act like class_addMethod.
//    IMP originalImplementation = class_replaceMethod(klass, @selector(forwardInvocation:), (IMP)__ASPECTS_ARE_BEING_CALLED__, "v@:@");
//    if (originalImplementation) {
//        class_addMethod(klass, NSSelectorFromString(AspectsForwardInvocationSelectorName), originalImplementation, "v@:@");
//    }
//    AspectLog(@"Aspects: %@ is now aspect aware.", NSStringFromClass(klass));
//}
//
//static Class aspect_swizzleClassInPlace(Class klass) {
//    NSCParameterAssert(klass);
//    NSString *className = NSStringFromClass(klass);
//
//    _aspect_modifySwizzledClasses(^(NSMutableSet *swizzledClasses) {
//        if (![swizzledClasses containsObject:className]) {
//            aspect_swizzleForwardInvocation(klass);
//            [swizzledClasses addObject:className];
//        }
//    });
//    return klass;
//}
//
//static Class aspect_hookClass(NSObject *self,NSError **error){
//    NSCParameterAssert(self);
//    Class statedClass = self.class;
//    Class baseClass = object_getClass(self);
//    NSString *className = NSStringFromClass(baseClass);
//
//    // Already subclassed
//    if ([className hasSuffix:AspectsSubclassSuffix]) {
//        return baseClass;
//        //We swizzle a class object, not a single object.
//    }else if (class_isMetaClass(baseClass)){
//        return aspect_swizzleClassInPlace((Class)self);
//    }else if (statedClass != baseClass){
//        return aspect_swizzleClassInPlace(baseClass);
//    }
//
//
//
//}
//
//
//
//
//static void aspect_prepareClassAndHookSelector(NSObject *self,SEL selector,NSError **error){
//    NSCParameterAssert(selector);
////    Class klass =
//
//}
//
//static id aspect_add(id self,SEL selector,AspectOptions options,id block,NSError **error)
//{
//    NSCParameterAssert(self);
//    NSCParameterAssert(selector);
//    NSCParameterAssert(block);
//    __block AspectIdentifier *identifier = nil;
//    aspect_performLocked(^{
//        if (aspect_isSelectorAllowedAndTrack(self, selector, options, error)) {
//            AspectsContainer *aspectContainer = aspect_getContainerForObject(self, selector);
//            identifier = [AspectIdentifier identifierWithSelector:selector object:self options:options block:block error:error];
//            if (identifier) {
//                [aspectContainer addAspect:identifier withOptions:options];
//
//                // Modify the class to allow message interception.
//
//            }
//        }
//
//    });
//    return identifier;
//}
//
//static NSMutableDictionary *aspect_getSwizzledClassedDict(){
//    static NSMutableDictionary *swizzledClassesDict;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        swizzledClassesDict = [NSMutableDictionary new];
//    });
//    return swizzledClassesDict;
//}
//
//static BOOL aspect_isSelectorAllowedAndTrack(NSObject *self,SEL selector,AspectOptions options,NSError **error){
//    static NSSet *disallowedSelectorList;
//    static dispatch_once_t pred;
//    dispatch_once(&pred, ^{
//        disallowedSelectorList = [NSSet setWithObjects:@"retain",@"release",@"autorelease",@"forwardInvocation:", nil];
//    });
//    // Check against the blacklist.
//    NSString *selectorName = NSStringFromSelector(selector);
//    if ([disallowedSelectorList containsObject:selectorName]) {
//        NSString *errorDeacription = [NSString stringWithFormat:@"Selector %@ is blacklisted.",selectorName];
//        AspectError(AspectErrorSelectorBlackListed, errorDeacription);
//        return NO;
//    }
//    // Additional checks.
//    AspectOptions position = options&AspectPositionFilter;
//    if ([selectorName isEqualToString:@"dealloc"] && position != AspectPositionBefore) {
//        NSString *errorDesc = @"AspectPositionBefore is the only valid position when hooking dealloc";
//        AspectError(AspectErrorSelectorDeallocPosition, errorDesc);
//        return NO;
//    }
//
//    if (![self respondsToSelector:selector] && ![self.class instancesRespondToSelector:selector]) {
//        NSString *errorDesc = [NSString stringWithFormat:@"Unable to find selector -[%@ %@].",NSStringFromClass(self.class),selectorName];
//        AspectError(AspectErrorDoesNotRespondToSelector, errorDesc);
//        return NO;
//    }
//    // Search for the current class and the class hierarchy IF we are modifying a class object
//    if (class_isMetaClass(object_getClass(self))) {
//        Class klass = [self class];
//        NSMutableDictionary *swizzledClassesDict = aspect_getSwizzledClassedDict();
//        Class currentClass = self.class;
//        do {
//            AspectTracker *tracker = swizzledClassesDict[currentClass];
//            if ([tracker.selectorNames containsObject:selectorName]) {
//                // Find the topmost class for the log.
//                if (tracker.parentEntry) {
//                    AspectTracker *topmostEntry = tracker.parentEntry;
//                    while (topmostEntry.parentEntry) {
//                        topmostEntry = topmostEntry.parentEntry;
//                    }
//                    NSString *errorDescription = [NSString stringWithFormat:@"Error:%@ already hooked in %@. A method can only be hooked once per class hierarchy.",selectorName,NSStringFromClass(topmostEntry.trackedClass)];
//                    AspectError(AspectErrorSelectorAlreadyHookedInClassHierarchy, errorDescription);
//                    return NO;
//                }else if (klass == currentClass){
//                    // Already modified and topmost!
//                    return YES;
//                }
//            }
//        } while (currentClass == class_getSuperclass(currentClass));
//
//        //Add the selector as being modified.
//        currentClass = klass;
//        AspectTracker *parentTracker = nil;
//        do {
//            AspectTracker *tracker = swizzledClassesDict[currentClass];
//            if (!tracker) {
//                tracker = [[AspectTracker alloc]initWithTrackedClass:currentClass parent:parentTracker];
//                swizzledClassesDict[(id<NSCopying>)currentClass] = tracker;
//            }
//            [tracker.selectorNames addObject:selectorName];
//            //All superclasses get marked as having a subclass that is modified.
//            parentTracker = tracker;
//        } while ((currentClass = class_getSuperclass(currentClass)));
//    }
//    return YES;
//}
//
//static void aspect_performLocked(dispatch_block_t block){
//    static OSSpinLock aspect_lock = OS_SPINLOCK_INIT;
//    OSSpinLockLock(&aspect_lock);
//    block();
//    OSSpinLockUnlock(&aspect_lock);
//}
//
//
//@end
//
//
//@implementation Aspects
//
//@end

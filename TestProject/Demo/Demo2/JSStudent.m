//
//  JSStudent.m
//  TestProject
//
//  Created by lmg on 2018/8/8.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import "JSStudent.h"
#import "JSScore.h"

@implementation JSStudent
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"userName":@"user_Name",@"userId":@"user_Id"};
}
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"scores":[JSScore class]};
}
+(Class)modelCustomClassForDictionary:(NSDictionary *)dictionary
{
    return [self class];
}
//+(NSArray<NSString *> *)modelPropertyBlacklist
//{
//    return @[@"userName"];
//}
//+(NSArray<NSString *> *)modelPropertyWhitelist
//{
//    return @[];
//}
-(NSDictionary *)modelCustomWillTransformFromDictionary:(NSDictionary *)dic
{
    NSMutableDictionary *result = dic.mutableCopy;
    if (result[@"user_Id"]) {
        result[@"user_Id"] = @"888888";
    }
    return result;
}
-(BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic
{
    return YES;
}
-(BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic
{
    return YES;
}
-(NSString *)description
{
   return  [self modelDescription];
}
@end

//
//  YYModelDemo.m
//  TestProject
//
//  Created by lmg on 2018/8/8.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import "YYModelDemo.h"
#import "NSObject+YYModel.h"
#import "JSScore.h"
#import "JSStudent.h"

@interface YYModelDemo ()

@end

@implementation YYModelDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSDictionary *dictionary = @{
                                 @"user_Name":@"jake",
                                 @"gender":@"男",
                                 @"user_Id":@"123456",
                                 @"scores":@[@{@"subject":@"语文",@"subjectId":@"1",@"score":@"80"},@{@"subject":@"数学",@"subjectId":@"2",@"score":@"85"},@{@"subject":@"英语",@"subjectId":@"3",@"score":@"88"}]
                                 };
    NSDictionary *dict = @{@"hello":dictionary};
    NSDictionary *dict1 = [NSDictionary modelDictionaryWithClass:[JSStudent class] json:dict];
    
    NSArray *array1 = [NSArray modelArrayWithClass:[JSStudent class] json:@[dictionary,dictionary]];
    
    JSStudent *student = [JSStudent modelWithDictionary:dictionary];
    NSDictionary *resultDict = [student modelToJSONObject];
    NSLog(@"----%@---%@----%@-----%@",dict1,array1,student,resultDict);
}


@end

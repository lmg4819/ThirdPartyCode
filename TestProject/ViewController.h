//
//  ViewController.h
//  TestProject
//
//  Created by lmg on 2018/7/31.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SuccessBlock)(id model, NSInteger resultCode, NSString* stateDescription);
typedef void (^FailBlock)(NSString *errorStr);

@interface ViewController : UIViewController

/*

 */
@end
/*
 
 vtype 1.创建  2.查看（暂无）  3.删除（驳回）  4.草稿箱 5.复制报告 6.待处理，处理中
 
 车辆配置信息页面
 
 1 4 5 可编辑（有确认按钮）
 2 3 6 不可编辑（无确认按钮）
 
 漆膜设置界面
 
 1 4 5 可编辑（有提交按钮）
 车辆型号信息为空，车辆型号可编辑，其他不可编辑；
 车辆型号不为空或者手动选择车辆型号以后，可编辑
 
 
 2 3 6 不可编辑（无提交按钮）
 
 
 */


/*


 
 
 */

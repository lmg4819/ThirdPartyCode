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
 
 
 //MGMS header 27
 {
 "Accept-Encoding" = gzip;
 al = "";
 e = 0;
 dn = iPhone;
 clienttype = 1;
 at = app;
 imei = "FDE9D5AD-9849-4A73-96F0-9CF6818E99BC";
 version = "1.0";
 z = 0;
 ip = "fe80::e49d:fadc:ba36:4ed4";
 ll = "";
 n = 2;
 os = iOS;
 ow = 0;
 p = 4;
 pm = "iPhone 6 Plus";
 s = AppStore;
 sc = "414*736";
 sv = "11.4";
 
 app = 1;
 businessid = 69012;
 memberCode = 69012;
 memberTel = 13211111111;
 onlineid = "";
 shopMemberCode = US033326;
 tid = "FDE9D5AD-9849-4A73-96F0-9CF6818E99BC1533784416225";
 username = "%E9%BB%84%E6%B5%B7%E5%8B%87";
 
 }

 
 //精估棒 header 28
 {
 "Accept-Encoding" = gzip;
 al = "";
 e = 0;
 dn = iPhone;
 clienttype = 1;
 at = app;
 imei = "FDE9D5AD-9849-4A73-96F0-9CF6818E99BC";
 version = "1.4.3";
 z = 0;
 ip = "fe80::e49d:fadc:ba36:4ed4";
 ll = "116.406318,40.004957";
 n = 2;
 os = iOS;
 ow = 0;
 p = 4;
 pm = "iPhone 6 Plus";
 s = AppStore;
 sc = "414*736";
 sv = "11.4";
 
 
 app = 80;
 businessid = 147910;
 memberCode = US033635;
 memberTel = 13716459804;
 onlineid = "d7c534e4-0c26-4d34-98d8-efbf0bc94a9d";
 shopMemberCode = US033635;
 tid = "FDE9D5AD-9849-4A73-96F0-9CF6818E99BC1533533996558";
 username = jgb1;
 
 
 ClientID = 87e70b55e5af591769072bc216d840d9;

 }

 
 
 */

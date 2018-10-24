//
//  CYPGarageQuantityObj.h
//  CarEasyBuy
//
//  Created by admin on 16/8/19.
//  Copyright © 2016年 北京巅峰科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MGMSPhotoListModel:NSObject
@property(strong,nonatomic) NSString * PicDescription;   //图片描述
@property(strong,nonatomic) NSString * PicPath;          //图片地址
@property(strong,nonatomic) NSString * OriginalPicPath;  //原图
@end

@interface MGMSBasicInfoModel:NSObject
@property(strong,nonatomic) NSString *CarVin;            //vin码
@property(strong,nonatomic) NSString *License;           //车牌号
@property(strong,nonatomic) NSString *Location;          //车辆所在地
@property(strong,nonatomic) NSArray<MGMSPhotoListModel *> *PhotoList;//基本照片
@property(strong,nonatomic) NSString *ProductName;       //车辆名称

@end

@interface MGMSEvaluationModel : NSObject
@property(strong,nonatomic)NSString *BuyCarPrice;        //收车指导价
@property(assign,nonatomic)BOOL BuyCarPriceSwitch;       //收车指导价开关 0 关闭，1 开启 ,
@property (nonatomic,assign) BOOL repairSwitch;          //维保开关
@property (nonatomic,assign) BOOL insuranceSwitch;       //保险开关
@property (nonatomic,assign) BOOL illegalSwitch;         //违章开关
@property(strong,nonatomic)NSString *EvaluationStatus;   //估值状态 1 待处理，2 处理中 ，3 已驳回, 4 已完成 ，5 已超时
@property(strong,nonatomic)NSString *NewCarPrice;        //新车指导价
@property(strong,nonatomic)NSString *SellerCarPrice;     //卖车指导价
@property(assign,nonatomic)BOOL SellerCarPriceSwitch;    //卖车指导价开关 0 关闭，1开启
@property (nonatomic,copy) NSString *appraiser;          //评估师姓名
@end
@interface MGMSReportListModel:NSObject
@property(strong,nonatomic)NSArray *ExceptionItem;       //异常信息
@property(strong,nonatomic)NSString *ReportStatus;       //报告状态 0 异常 1 正常 ,
@property(strong,nonatomic)NSString *ReportName;         //报告项

@end
@interface MGMSReportModel:NSObject
//违章
@property(strong,nonatomic)NSString *IllegalCount;       //违章数量
@property(strong,nonatomic)NSString *IllegalUrl;         //违章地址
@property(strong,nonatomic)NSString *IllegalStatus;      //违章查询状态 -1 不显示违章查询 0 未查询，1 查询中，2 有结果,3 查询没数据，4 查询失败
//保险
@property(strong,nonatomic)NSString *InsuranceCount;     //保险数量
@property(strong,nonatomic)NSString *InsuranceStatus;    //保险查询状态 -1 不显示保险查询 0 未查询，1 查询中，2 有结果,3 查询没数据，4 查询失败
@property(strong,nonatomic)NSString *InsuranceUrl;       //保险地址

@property(strong,nonatomic)NSString *OtherMessage;       //其他信息
@property(strong,nonatomic)NSString *RepairCount;        //维修保养次数
@property(strong,nonatomic)NSString *RepairStatus;       //维修保养查询状态 -1 不显示维保查询 0 未查询，1 查询中，2 有结果

@property(strong,nonatomic)NSString *RepairUrl;          //维修保养详情页地址
@property(strong,nonatomic)NSArray<MGMSReportListModel *> *ReportList;// 报告检测项集合
@property(strong,nonatomic)NSString *ReportUrl;          //报告地址

@end

@interface MGMSGarageDetailModel:NSObject
@property(strong,nonatomic)MGMSBasicInfoModel *BasicInfo;  //基本信息
@property(strong,nonatomic)MGMSEvaluationModel *Evaluation;//车辆估值
@property(strong,nonatomic)NSArray *GoodList;              //车辆信息
@property(strong,nonatomic)NSArray *OrderList;             //订单信息
@property(strong,nonatomic)MGMSReportModel *ReportInfo;    //报告检测项

@end



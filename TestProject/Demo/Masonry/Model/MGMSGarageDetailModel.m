//
//  CYPGarageQuantityObj.m
//  CarEasyBuy
//
//  Created by admin on 16/8/19.
//  Copyright © 2016年 北京巅峰科技有限公司. All rights reserved.
//

#import "MGMSGarageDetailModel.h"

@implementation MGMSPhotoListModel

- (NSDictionary *)modelCustomWillTransformFromDictionary:(NSDictionary *)dic
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:dic];
    if ([dic[@"description"] isKindOfClass:[NSNull class]]) {
        dict[@"description"] = @"";
    }
    return dict;
}
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{
             @"PicDescription":@"description",
             @"PicPath":@"picPath",
             @"OriginalPicPath":@"originalPicPath"
             };
}

@end
@implementation MGMSGarageDetailModel

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{
             @"BasicInfo":@"basicInfo",
             @"Evaluation":@"evaluation",
             @"GoodList":@"goodList",
             @"OrderList":@"orderList",
             @"ReportInfo":@"reportInfo"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"BasicInfo" : [MGMSBasicInfoModel class],
             @"Evaluation" : [MGMSEvaluationModel class],
             @"ReportInfo" : [MGMSReportModel class]
             };
}


@end

@implementation MGMSBasicInfoModel
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{
             @"CarVin":@"carVin",
             @"License":@"license",
             @"Location":@"location",
             @"PhotoList":@"photoList",
             @"ProductName":@"productName"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"PhotoList" : [MGMSPhotoListModel class]};
}
@end
@implementation MGMSReportModel
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{
             @"IllegalCount":@"illegalCount",
             @"IllegalStatus":@"illegalStatus",
             @"IllegalUrl":@"illegalUrl",
             @"InsuranceCount":@"insuranceCount",
             @"InsuranceStatus":@"insuranceStatus",
             @"InsuranceUrl":@"insuranceUrl",
             @"OtherMessage":@"otherMessage",
             @"RepairCount":@"repairCount",
             @"RepairStatus":@"repairStatus",
             @"RepairUrl":@"repairUrl",
             @"ReportList":@"reportList",
             @"ReportUrl":@"reportUrl"
             };
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"ReportList" : [MGMSReportListModel class]};
}

@end
@implementation MGMSEvaluationModel
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{
             @"BuyCarPrice":@"buyCarPrice",
             @"BuyCarPriceSwitch":@"buyCarPriceSwitch",
             @"EvaluationStatus":@"evaluationStatus",
             @"SellerCarPrice":@"sellerCarPrice",
             @"SellerCarPriceSwitch":@"sellerCarPriceSwitch",
             @"NewCarPrice":@"newCarPrice",
             @"EvaluationStatus":@"evaluationStatus",
             @"RepairSwitch":@"repairSwitch",
             @"IllegalSwitch":@"illegalSwitch",
             @"InsuranceSwitch":@"insuranceSwitch"
             };
}
@end
@implementation MGMSReportListModel

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{
             @"ExceptionItem":@"exceptionItem",
             @"ReportStatus":@"reportStatus",
             @"ReportName":@"reportName",
             };
}
@end

//
//  SVProgressHUDDemo.m
//  TestProject
//
//  Created by lmg on 2018/8/8.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import "SVProgressHUDDemo.h"
#import "SVProgressHUD.h"

@interface SVProgressHUDDemo ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataList;
@end

@implementation SVProgressHUDDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
     SVProgressHUDStyleLight:白色HUD背景，黑色text内容，HUD背景会被模糊处理
     SVProgressHUDStyleDark:黑色HUD背景，白色text内容，HUD背景会被模糊处理
     SVProgressHUDStyleCustom:自定义HUD颜色，和text内容颜色，HUD背景不会被模糊处理
     */
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];//default
//    //HUD背景颜色
//    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
//    //text内容颜色
//    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    
    /*
     SVProgressHUDMaskTypeNone:没有遮罩，当HUD展示的时候，背景View可以被点击
     SVProgressHUDMaskTypeClear:背景View不可被点击，透明遮罩
     SVProgressHUDMaskTypeBlack:背景View不可被点击，黑色遮罩：[UIColor colorWithWhite:0 alpha:0.4];
     SVProgressHUDMaskTypeGradient:背景View不可被点击,颜色渐变遮罩
     SVProgressHUDMaskTypeCustom:背景View不可被点击,自定义遮罩背景颜色
     */
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];//default
    
    //默认颜色[UIColor colorWithWhite:0 alpha:0.4];配合SVProgressHUDMaskTypeCustom使用，设置遮罩颜色
//    [SVProgressHUD setBackgroundLayerColor:[UIColor redColor]];
    
    /*
     SVProgressHUDAnimationTypeFlat:无限循环的自定义动画
     SVProgressHUDAnimationTypeNative:系统原生的动画
     */
//    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];//default
    
    [SVProgressHUD setMinimumSize:CGSizeMake(120, 120)];//HUD的最小尺寸
//    [SVProgressHUD setImageViewSize:CGSizeMake(28, 28)];//image的尺寸
//    [SVProgressHUD setRingThickness:2];//圆环厚度
//    [SVProgressHUD setRingRadius:18];//圆环半径,有文字时
//    [SVProgressHUD setRingNoTextRadius:24];//圆环半径，无文字时
//    [SVProgressHUD setCornerRadius:14];//HUD的圆角半径
//    [SVProgressHUD setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]];//副标题
//    [SVProgressHUD setBorderColor:nil];//HUD的边框颜色
//    [SVProgressHUD setBorderWidth:0];//HUD的边框半径
    
//    [SVProgressHUD setInfoImage:nil];//InfoImage
//    [SVProgressHUD setSuccessImage:nil];//SuccessImage
//    [SVProgressHUD setErrorImage:nil];//ErrorImage
    
//    [SVProgressHUD setGraceTimeInterval:0];//设置展示延迟时间间隔
    
    /*
     设置最短展示时间，只对展示图片时才有效
     */
//    [SVProgressHUD setMinimumDismissTimeInterval:5.0];
    /*
     设置最长展示时间，只对展示图片时才有效
     */
//    [SVProgressHUD setMaximumDismissTimeInterval:MAXFLOAT];
//    [SVProgressHUD setFadeInAnimationDuration:0.15];//淡入动画时间间隔
//    [SVProgressHUD setFadeOutAnimationDuration:0.15];//淡出动画时间间隔
//
//    [SVProgressHUD resetOffsetFromCenter];//重置HUD的center位置
//    [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0, 0)];//设置HUD的center位置
//
//    [SVProgressHUD setShouldTintImages:YES];//根据tintColor绘制图片，忽略图片的颜色信息
    
    
    self.dataList = @[@"show",@"showWithStatus",@"showProgress",@"showProgress:status",@"showInfoWithStatus",@"showSuccessWithStatus",@"showErrorWithStatus",@"dismiss"];
    
    [self.view addSubview:self.tableView];
}

#pragma mark -UITableViewDelegate,UITableViewDataSource
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataList[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [SVProgressHUD show];
    }else if (indexPath.row == 1){
        [SVProgressHUD showWithStatus:@"正在加载"];
    }else if (indexPath.row == 2)
    {
        [SVProgressHUD showProgress:0.4];
    }else if (indexPath.row == 3)
    {
        [SVProgressHUD showProgress:0.4 status:@"正在加载"];
    }else if (indexPath.row == 4)
    {
        [SVProgressHUD showInfoWithStatus:@"正在加载"];
    }else if (indexPath.row == 5)
    {
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
    }else if (indexPath.row == 6)
    {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }else if (indexPath.row == 7)
    {
        [SVProgressHUD dismiss];
    }
}

@end

//
//  MGMSViewController.m
//  TestProject
//
//  Created by lmg on 2018/8/28.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import "MGMSViewController.h"
#import "MGMSGarageDetailModel.h"
#import "MGMSCarInfoTableViewCell.h"
#import "MGMSNetworkTool.h"
#import "NSObject+YYModel.h"

@interface MGMSViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) MGMSGarageDetailModel *detailModel;
@end

@implementation MGMSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self requestData];
}
-(void)requestData
{
    __weak typeof(self) weakSelf = self;
    [MGMSNetworkTool requestGarageInfoWithProductName:@"M180822155436001" andEvaluationNO:@"EDS120180823101712340871" successBlock:^(id responseObject) {
        if (responseObject) {
            weakSelf.detailModel = [MGMSGarageDetailModel modelWithJSON:responseObject[@"data"]];
            [weakSelf.tableView reloadData];
        }
    } failBlcok:^(NSError *error) {
        
    }];
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
    return self.detailModel.ReportInfo.ReportList.count>0?self.detailModel.ReportInfo.ReportList.count:1;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGMSCarInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[MGMSCarInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    cell.listModel = self.detailModel.ReportInfo.ReportList[indexPath.row];
    return cell;
}


@end

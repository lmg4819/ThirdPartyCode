//
//  ViewController.m
//  TestProject
//
//  Created by lmg on 2018/7/31.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import "ViewController.h"
#import "SVProgressHUD.h"
#import <KVOController/KVOController.h>
#import "UIView+MJExtension.h"
#import <pthread.h>
#import <YYKit/YYKit.h>
#import <YYKit/YYMemoryCache.h>
#import <YYKit/YYDiskCache.h>
#import "WBModel.h"
#import "AFNetworkingDemo.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIView+WebCache.h>
#import <AFNetworking/AFNetworking.h>

#import <pthread.h>
#import "FinancyContext.h"
#import "AliPayFinancyStartegy.h"
#import "YouLiFinancyStrategy.h"
#import "JSCombination.h"
#import "JSCommonTool.h"
#import "MJRefresh.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataList;

@property (nonatomic,strong) dispatch_queue_t serialQueue;
@property (nonatomic,strong) dispatch_queue_t concurrentQueue;

@property (nonatomic,strong) NSMutableArray *sourceArray;


@property (nonatomic,strong) dispatch_semaphore_t semaphore;

@property (nonatomic,copy) NSString *userName;

@end

@implementation ViewController

__weak NSString *weakString = nil;
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%s----%@",__func__,weakString);
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     NSLog(@"%s----%@",__func__,weakString);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    


    

//    JSCombination *combination = [[JSCombination alloc]init];
//
//    [combination performSelector:@selector(test)];
//    if ([combination class] == [JSCombination class]) {
//        NSLog(@"555555555555555555");
//    }
//
//    if ([combination isKindOfClass:[JSCommonTool class]]) {
//        NSLog(@"333333333333333333");
//    }
    
   // NSLog(@"%@============%d",[[JSCombination alloc] class],[[JSCombination alloc] isMemberOfClass:[JSCommonTool class]]);
    
//    NSString *tempStr = [NSString stringWithFormat:@"hello"];
//    weakString = tempStr;
//    NSLog(@"%s----%@",__func__,weakString);
//
//
    self.title = @"Three Party";
    self.dataList = @[@"SVProgressHUDDemo",@"YYModelDemo",@"WBStatusTimeLineViewController",@"AFNetworkingDemo",@"AdapterDemo",@"MGMSViewController"];
//
//
//
//    id<FinancyStartegyProtocal> aliPayFinancy = [AliPayFinancyStartegy new];
//    FinancyContext *context = [[FinancyContext alloc]initWithFinancy:aliPayFinancy];
//    NSInteger money = [context financyWithMonth:6 money:10000];
//    NSLog(@"Alipay money = %@", @(money));
//
//
//    id<FinancyStartegyProtocal> youLiFinancy = [YouLiFinancyStrategy new];
//    context.financy = youLiFinancy;
//    money = [context financyWithMonth:6 money:10000];
//    NSLog(@"YouLi money = %@", @(money));
//
//
//

    
    
 /*
  同步：不创建新线程
  
  异步：创建一条或者多条线程
  
  
  串行队列：不创建或者创建一条新线程
  主队列：  只有一条线程（主线程）
  
  并行队列：创建一条或者多条线程
  全局队列：创建一条或者多条线程
  
  同步+串行 不创建新线程
  同步+并行 不创建新线程
  
  异步+串行 创建一条新线程
  异步+并行 
  
  */
    
    
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView.mj_footer endRefreshing];
            [weakSelf.tableView reloadData];
        });
    }];
    
    [self.view addSubview:self.tableView];
    
    
}

#pragma mark -UITableViewDelegate,UITableViewDataSource
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, self.view.mj_w, self.view.mj_h-44-34)];
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
    NSString *classString = self.dataList[indexPath.row];
    UIViewController *vc = [NSClassFromString(classString) new];
    [self.navigationController pushViewController:vc animated:YES];
}



@end

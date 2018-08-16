//
//  ViewController.m
//  TestProject
//
//  Created by lmg on 2018/7/31.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import "ViewController.h"
#import "SVProgressHUD.h"
#import <KVOController.h>
#import "UIView+MJExtension.h"
#import <pthread.h>
#import <YYCache.h>
#import <YYMemoryCache.h>
#import <YYDiskCache.h>
#import "WBModel.h"
#import "AFNetworkingDemo.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking.h>




@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataList;

@end

@implementation ViewController
-(void)testDelay:(NSString *)str{
    NSLog(@"88888=====%@",str);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Three Party";
    self.dataList = @[@"SVProgressHUDDemo",@"YYModelDemo",@"WBStatusTimeLineViewController",@"AFNetworkingDemo"];
    // self.navigationController.navigationBar.hidden = YES;
    
    
    //    [self performSelector:@selector(testDelay:) withObject:@"hello" afterDelay:5];
    //    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(testDelay:) object:@"hello"];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://i.test.268v.com/small/c/1805/17/20180517093434-hxpjq4wee5k.jpg?w=500"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        if (error) {
//            NSLog(@"%@---",error);
//        }else
//        {
//            NSLog(@"===");
//        }
//    }];
   
    
    
    [self.view addSubview:imageView];

    
    
    YYCache *yyCache = [YYCache cacheWithName:@"LCJCache"];
    
    [yyCache.memoryCache setCountLimit:50];
    [yyCache.memoryCache setCostLimit:100*1024];
    
    [yyCache.diskCache setCountLimit:50];
    [yyCache.diskCache setCostLimit:100*1024];
    [yyCache.diskCache setAutoTrimInterval:60];//default
    
    WBStatus *status = [WBStatus new];
    status.idstr = @"123456";
    status.mid = @"123";
    status.rid = @"456";
    [yyCache setObject:status forKey:@"WBStatus" withBlock:^{
        NSLog(@"finished----finished");
    }];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        id obj = [yyCache.diskCache objectForKey:@"WBStatus"];
        NSLog(@"%@",((WBStatus *)obj).description);
    });
    
  // [self.view addSubview:self.tableView];
}

#pragma mark -UITableViewDelegate,UITableViewDataSource
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.mj_w, self.view.mj_h-64)];
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
    if (indexPath.row <= 2) {
        UIViewController *vc = [NSClassFromString(classString) new];
        [self.navigationController pushViewController:vc animated:YES];
    }else
    {
        
        [AFNetworkingDemo downloadImage];
        
//        NSString *reportCode = @"J180731111830001";
//        NSString *evaluationNo = @"EDS120180731111445964211";
//
//        [AFNetworkingDemo requestGarageInfo:reportCode andEvaluationNo:evaluationNo successData:^(id model, NSInteger resultCode, NSString *stateDescription) {
//            if (resultCode == 0) {
//                NSDictionary *dict = (NSDictionary *)model;
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:dict.description delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//                [alert show];
//
//            }
//        } FaillError:^(NSString *errorStr) {
//            if (errorStr) {
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:errorStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//                [alert show];
//            }
//        }];
    }
    
    
    
}



@end

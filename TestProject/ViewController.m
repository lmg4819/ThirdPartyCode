//
//  ViewController.m
//  TestProject
//
//  Created by lmg on 2018/7/31.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import "ViewController.h"
#import "JSProgressView.h"
#import "JSProgressViewConfig.h"
#import "UIView+MJExtension.h"
#import "NSData+YYAdd.h"
#import "NSString+YYAdd.h"
#import "UIApplication+JSCategory.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataList;

@property (nonatomic,strong) dispatch_queue_t serialQueue;
@property (nonatomic,strong) dispatch_queue_t concurrentQueue;

@property (nonatomic,strong) NSMutableArray *sourceArray;


@property (nonatomic,strong) dispatch_semaphore_t semaphore;

@property (nonatomic,copy) NSString *userName;

@property (nonatomic ,weak) UIButton *agreeButton;

@end

@implementation ViewController

- (void)agreeMethod:(UIButton *)sender
{
    [JSProgressView showHUD];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [JSProgressView dismiss];
    });
}

+ (void)show{

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] js_beganNetworkActivity];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] js_endedNetworkActivity];
    });
    
    NSString *string = @"helloWorld";
    NSString *base64String = string.base64EncodedString;
    NSString *originalString = [NSString stringWithBase64EncodedString:base64String];
    NSData *data = string.dataValue;
    
    
    self.dataList = @[@"show",@"showImage",@"showStatus",@"showHUDWithStatus",@"showImageWithStatus",@"dismiss",@"showHUDWithDuration",@"showWithStatusDuration",@"showWithImageDuration",@"showHUDWithStatusDuration",@"showWithImageDuration"];
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
    if (indexPath.row == 0) {
        JSProgressViewConfig *config = [JSProgressViewConfig defaultConfig];
        config.foregroundColor = [UIColor whiteColor];
        config.defaultAnimationStyle = JSProgressHUDAnimationStyleNative;
        config.backgroundColor = [UIColor colorWithWhite:0.3 alpha:1.0];
        [JSProgressView setCustomConfig:config];
        [JSProgressView showHUD];

        
        [JSProgressView cleanCustomConfig];
    }else if (indexPath.row == 1){
        [JSProgressView showWithImage:[UIImage imageNamed:@"Checkmark"]];
    }else if (indexPath.row == 2){
        [JSProgressView showWithStatus:@"欢迎光临"];
    }else if (indexPath.row == 3){
        [JSProgressView showHUDWithStatus:@"欢迎光临"];
    }else if (indexPath.row == 4){
        [JSProgressView showWithImage:[UIImage imageNamed:@"Checkmark"] status:@"欢迎光临"];
    }else if(indexPath.row == 5){
        [JSProgressView dismiss];
    }else if (indexPath.row == 6){
        [JSProgressView showHUDWithDuration:2.0];
    }else if (indexPath.row == 7){
        [JSProgressView showWithStatus:@"欢迎光临" duration:2.0];
    }else if (indexPath.row == 8){
        [JSProgressView showWithImage:[UIImage imageNamed:@"Checkmark"] duration:2.0];
    }else if (indexPath.row == 9){
        [JSProgressView showHUDWithStatus:@"欢迎光临" duration:2.0];
    }else if (indexPath.row == 10){
        [JSProgressView showWithImage:[UIImage imageNamed:@"Checkmark"] status:@"欢迎光临" duration:2.0];
    }
}


@end

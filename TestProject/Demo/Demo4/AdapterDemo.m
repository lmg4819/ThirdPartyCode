//
//  AdapterDemo.m
//  TestProject
//
//  Created by lmg on 2018/8/22.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import "AdapterDemo.h"
#import "ADTableViewCell.h"
#import "ADModel.h"
#import "ADModel1.h"
#import "Shape.h"

@interface AdapterDemo ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataListArray;
@property (nonatomic,copy) NSString *classString;

@end

@implementation AdapterDemo

-(instancetype)init
{
    ADModel *model = [[ADModel alloc]init];
    model.imageName = @"weizhang";
    model.userName = @"jake";
    model.dateTimeStr = @"08/22/2018";
    
    ADModel *model1 = [[ADModel alloc]init];
    model1.imageName = @"weizhang";
    model1.userName = @"jake1";
    model1.dateTimeStr = @"08/22/2018";
    
    ADModel *model2 = [[ADModel alloc]init];
    model2.imageName = @"weizhang";
    model2.userName = @"jake2";
    model2.dateTimeStr = @"08/22/2018";
    
    ADModel *model3 = [[ADModel alloc]init];
    model3.imageName = @"weizhang";
    model3.userName = @"jake3";
    model3.dateTimeStr = @"08/22/2018";
    
    ADModel1 *model4 = [[ADModel1 alloc]init];
    model4.adImageName = @"weizhang";
    model4.adUserName = @"ADModel11";
    model4.adDataTimeStr = @"18/22/2018";
    
    ADModel1 *model5 = [[ADModel1 alloc]init];
    model5.adImageName = @"weizhang";
    model5.adUserName = @"ADModel12";
    model5.adDataTimeStr = @"09/22/2018";
    
    
    return [self initWithCellClass:NSStringFromClass([ADTableViewCell class]) DataList:@[model,model1,model2,model3,model4,model5]];
}

-(instancetype)initWithCellClass:(NSString *)cellClass DataList:(NSArray *)dataList
{
    self = [super init];
    if (self) {
        self.classString = cellClass;
        self.dataListArray = dataList;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
   
    Shape *circle = [Shape getShapeWithType:ShapeTypeCircle];
    [circle draw];
    
    
    Shape *rectangle = [Shape getShapeWithType:ShapeTypeRectangle];
    [rectangle draw];
    
    Shape *square = [Shape getShapeWithType:ShapeTypeSquare];
    [square draw];
    
    NSNumber *intNumber = [NSNumber numberWithInt:10];
    NSNumber *floatNumber = [NSNumber numberWithFloat:102.3];
    NSNumber *boolNamuber = [NSNumber numberWithBool:YES];
    NSLog(@"%@----%@----%@",intNumber,floatNumber,boolNamuber);
    
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataListArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class class = NSClassFromString(self.classString);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[class alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.separatorInset = UIEdgeInsetsMake(0, 16, 0, 0);
    }
    if ([cell respondsToSelector:@selector(loadDate:)]) {
        [cell performSelector:@selector(loadDate:) withObject:self.dataListArray[indexPath.row]];
    }
    return cell;
}

@end

//
//  MGMSCarInfoTableViewCell.m
//  TestProject
//
//  Created by lmg on 2018/8/28.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import "MGMSCarInfoTableViewCell.h"
#import "MGMSGarageDetailModel.h"
#import "Masonry.h"

#define UIColorRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

@implementation MGMSCarInfoTableViewCell
{
    UILabel *_reportNameLabel;
    UIView *_lineView;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
    }
    return self;
}
-(void)addSubviews
{
    UILabel *nameLabel = [UILabel new];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = UIColorRGB(0x555555);
    [self.contentView addSubview:nameLabel];
    _reportNameLabel = nameLabel;
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = UIColorRGB(0xe2e2e2);
    [self.contentView addSubview:lineView];
    _lineView = lineView;
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(111);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(18);
        make.bottom.mas_equalTo(-18);
    }];
    
    [_reportNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(17);
        make.right.mas_equalTo(self->_lineView.mas_left).mas_offset(-10);
    }];
}
-(void)setListModel:(MGMSReportListModel *)listModel
{
    
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    _listModel = listModel;
    [self addSubviews];
    _reportNameLabel.text = listModel.ReportName;
    if (listModel.ReportStatus.boolValue) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jgbzhengchang"]];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self->_lineView.mas_right).mas_offset(10);
            make.width.mas_equalTo(16);
            make.height.mas_equalTo(16);
            make.top.mas_equalTo(self->_reportNameLabel);
        }];
        
        UILabel *contentLabel = [UILabel new];
        contentLabel.font = [UIFont systemFontOfSize:14];
        contentLabel.textColor = UIColorRGB(0x555555);
        contentLabel.text = @"未见明显异常";
        [self.contentView addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageView.mas_right).mas_offset(10);
            make.top.mas_equalTo(self->_reportNameLabel);
            make.bottom.mas_equalTo(-17);
        }];

    }else
    {
        int i=0;
        NSUInteger count = listModel.ExceptionItem.count;
       
        for (NSDictionary *dict in listModel.ExceptionItem) {
            UILabel *textLabel = [UILabel new];
            textLabel.font = [UIFont systemFontOfSize:14];
            textLabel.textColor = UIColorRGB(0x555555);
            textLabel.text = dict[@"key"];
            textLabel.numberOfLines = 2;
            [self.contentView addSubview:textLabel];
            [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self->_lineView).mas_offset(10);
                make.top.mas_equalTo(self->_reportNameLabel).mas_offset(i*40);
                make.width.mas_equalTo((SCREEN_WIDTH-131)/2);
            }];
            
            UILabel *detailLabel = [UILabel new];
            detailLabel.font = [UIFont systemFontOfSize:14];
            detailLabel.textColor = UIColorRGB(0xff7145);
            detailLabel.text = dict[@"value"];
            detailLabel.numberOfLines = 2;
            [self.contentView addSubview:detailLabel];
            
            [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(textLabel.mas_right).mas_offset(10);
                make.right.mas_equalTo(-10);
                make.top.mas_equalTo(textLabel);
                if (i == count - 1) {
                    make.bottom.mas_equalTo(-17).priorityLow();
                }
            }];
            MASAttachKeys(detailLabel);
            i++;
        }
    }
}

@end

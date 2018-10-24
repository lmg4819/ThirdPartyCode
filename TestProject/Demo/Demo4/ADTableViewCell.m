//
//  ADTableViewCell.m
//  TestProject
//
//  Created by lmg on 2018/8/22.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import "ADTableViewCell.h"

@implementation ADTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(16, (self.bounds.size.height-30)/2, 30, 30);
    self.textLabel.frame = CGRectMake(16+40, (self.bounds.size.height-40)/2, self.bounds.size.width-32-40, 20);
    self.detailTextLabel.frame = CGRectMake(16+40, (self.bounds.size.height-40)/2+20, self.bounds.size.width-32-40, 20);
}

- (void)loadDate:(id<ADAdapterProticol>)data
{
    self.imageView.image = data.image;
    self.textLabel.text = data.text;
    self.detailTextLabel.text = data.detailText;
}

@end

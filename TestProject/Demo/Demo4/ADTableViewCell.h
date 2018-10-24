//
//  ADTableViewCell.h
//  TestProject
//
//  Created by lmg on 2018/8/22.
//  Copyright © 2018年 lmg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADAdapterProticol.h"

@interface ADTableViewCell : UITableViewCell

-(void)loadDate:(id<ADAdapterProticol>)data;


@end

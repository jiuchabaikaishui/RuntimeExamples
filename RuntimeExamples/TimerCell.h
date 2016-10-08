//
//  TimerCell.h
//  RuntimeExamples
//
//  Created by 綦 on 16/9/18.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeModel.h"

@interface TimerCell : UITableViewCell

@property (strong, nonatomic) TimeModel *timeModel;

+ (instancetype)timerCell:(UITableView *)tableView;

@end

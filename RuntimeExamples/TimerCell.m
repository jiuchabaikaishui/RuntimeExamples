//
//  TimerCell.m
//  RuntimeExamples
//
//  Created by 綦 on 16/9/18.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "TimerCell.h"

#define Observer_Key        @"time"

@implementation TimerCell

- (void)setTimeModel:(TimeModel *)timeModel
{
    if (_timeModel) {
        [_timeModel removeObserver:self forKeyPath:Observer_Key];
    }
    _timeModel = timeModel;
    [_timeModel addObserver:self forKeyPath:Observer_Key options:NSKeyValueObservingOptionNew context:nil];
    self.detailTextLabel.text = [NSString stringWithFormat:@"%i", (int)timeModel.time];
}

- (void)dealloc
{
    if (self.timeModel) {
        [self.timeModel removeObserver:self forKeyPath:Observer_Key];
    }
}
+ (instancetype)timerCell:(UITableView *)tableView
{
    static NSString *identifier = @"TimerCellIdentifier";
    TimerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[TimerCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        self.textLabel.text = @"时间：";
        self.detailTextLabel.text = @"0";
    }
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:Observer_Key]) {
        self.detailTextLabel.text = [NSString stringWithFormat:@"%i", (int)self.timeModel.time];
    }
}

@end

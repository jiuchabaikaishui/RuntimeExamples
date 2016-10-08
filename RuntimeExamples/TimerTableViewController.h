//
//  TimerTableViewController.h
//  RuntimeExamples
//
//  Created by 綦 on 16/9/18.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, TimerTableViewControllerType){
    TimerTableViewControllerTypeMemoryLeak = 0,
    TimerTableViewControllerTypeRuntime = 1,
    TimerTableViewControllerTypeDelegate = 2
};

@interface TimerTableViewController : UITableViewController

@property (assign, nonatomic) TimerTableViewControllerType type;

@end

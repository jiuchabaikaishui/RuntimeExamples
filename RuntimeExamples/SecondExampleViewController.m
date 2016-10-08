//
//  SecondExampleViewController.m
//  RuntimeExamples
//
//  Created by 綦 on 16/9/18.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "SecondExampleViewController.h"
#import "TimerTableViewController.h"

#define MemoryLeak_Segue            @"MemoryLeakSegue"
#define Runtime_Segue               @"RuntimeSegue"
#define Delegate_Segue              @"DelegateSegue"

@implementation SecondExampleViewController

#pragma mark - 控制器周期
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    TimerTableViewController *nextCtr = (TimerTableViewController *)segue.destinationViewController;
    if ([segue.identifier isEqualToString:MemoryLeak_Segue]) {
        nextCtr.type = TimerTableViewControllerTypeMemoryLeak;
    }
    if ([segue.identifier isEqualToString:Runtime_Segue]) {
        nextCtr.type = TimerTableViewControllerTypeRuntime;
    }
    if ([segue.identifier isEqualToString:Delegate_Segue]) {
        nextCtr.type = TimerTableViewControllerTypeDelegate;
    }
}

@end

//
//  ThirdExampleViewController.m
//  RuntimeExamples
//
//  Created by 綦 on 16/9/19.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "ThirdExampleViewController.h"
#import "StatisticsTableViewController.h"

@implementation ThirdExampleViewController

- (IBAction)statisticsButtonAction:(UIButton *)sender {
    [self performSegueWithIdentifier:@"StatisticsSegue" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    StatisticsTableViewController *ctr = segue.destinationViewController;
    ctr.hidesBottomBarWhenPushed = YES;
}

@end

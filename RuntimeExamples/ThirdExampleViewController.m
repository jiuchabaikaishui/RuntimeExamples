//
//  ThirdExampleViewController.m
//  RuntimeExamples
//
//  Created by 綦 on 16/9/19.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "ThirdExampleViewController.h"
#import <objc/objc-class.h>

@implementation ThirdExampleViewController

- (IBAction)statisticsButtonAction:(UIButton *)sender {
    [self performSegueWithIdentifier:@"StatisticsSegue" sender:sender];
//    Class *classes = NULL;
//    
//    int count = objc_getClassList(classes, 0);
//    NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:1];
//    if (count > 0) {
//        classes = malloc(sizeof(Class)*count);
//        objc_getClassList(classes, count);
//        for (int index = 0; index < count; index++) {
//            Class theClass = classes[index];
//            NSLog(@"第%i个类：%@", index, NSStringFromClass(theClass));
//            if (class_getSuperclass(classes[index]) == [UIViewController class]) {
//                [mArr addObject:theClass];
//            }
//        }
//    }
//    
//    NSLog(@"%@", mArr);
}

@end

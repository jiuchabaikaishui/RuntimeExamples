//
//  TimerTarget.m
//  RuntimeExamples
//
//  Created by 綦 on 16/9/18.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "TimerTarget.h"

@implementation TimerTarget

- (void)timerAction:(NSTimer *)timer
{
    if ([self.delegate respondsToSelector:@selector(timerTargetDelegate:)]) {
        [self.delegate timerTargetDelegate:self];
    }
}

@end

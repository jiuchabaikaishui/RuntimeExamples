//
//  TimerTarget.h
//  RuntimeExamples
//
//  Created by 綦 on 16/9/18.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TimerTarget;
@protocol TimerTargetDelegate <NSObject>

- (void)timerTargetDelegate:(TimerTarget *)timerTarget;

@end

@interface TimerTarget : NSObject

@property (weak, nonatomic) id delegate;

- (void)timerAction:(NSTimer *)timer;

@end

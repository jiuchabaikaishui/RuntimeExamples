//
//  TimeModel.m
//  RuntimeExamples
//
//  Created by 綦 on 16/9/18.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "TimeModel.h"

@implementation TimeModel

+ (instancetype)timeModel:(NSInteger)time
{
    return [[self alloc] initWithTime:time];
}
- (instancetype)initWithTime:(NSInteger)time
{
    if (self = [super init]) {
        self.time = time;
    }
    
    return self;
}

@end

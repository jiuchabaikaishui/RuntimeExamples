//
//  TimeModel.h
//  RuntimeExamples
//
//  Created by 綦 on 16/9/18.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeModel : NSObject

@property (assign, nonatomic) NSInteger time;

+ (instancetype)timeModel:(NSInteger)time;
- (instancetype)initWithTime:(NSInteger)time;

@end

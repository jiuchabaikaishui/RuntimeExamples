//
//  UIView+Tap.h
//  RuntimeExamples
//
//  Created by 綦 on 16/9/13.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Tap)

/**
 *  添加点击手势
 *
 *  @param action 手势执行的动作
 */
- (void)tapAction:(void (^)())action;

@end

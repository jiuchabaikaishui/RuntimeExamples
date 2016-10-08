//
//  UIView+Tap.m
//  RuntimeExamples
//
//  Created by 綦 on 16/9/13.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "UIView+Tap.h"
#import <objc/objc.h>
#import <objc/objc-class.h>

#define TapGesture                    "TapGestureRecognizer"
#define TapGestureAction                    "TapGestureAction"

@implementation UIView (Tap)

/**
 *  添加点击手势
 *
 *  @param action 手势执行的动作
 */
- (void)tapAction:(void (^)())action
{
    //获取点击手势属性
    UITapGestureRecognizer *tapGesture = objc_getAssociatedObject(self, &TapGesture);
    
    //是否获取到点击手势
    if (!tapGesture) {
        //创建点击手势
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        //把手势添加到视图
        [self addGestureRecognizer:tapGesture];
        //添加点击手势属性
        objc_setAssociatedObject(self, &TapGesture, tapGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    //添加点击手势响应代码块属性
    objc_setAssociatedObject(self, &TapGestureAction, action, OBJC_ASSOCIATION_RETAIN);
}

/**
 *  点击手势执行的方法
 *
 *  @param sender 点击手势
 */
- (void)tapGestureAction:(UITapGestureRecognizer *)sender
{
    void (^action)() = objc_getAssociatedObject(self, &TapGestureAction);
    if (action) {
        action();
    }
}

@end

//
//  UIViewController+MethodSwizzling.m
//  RuntimeExamples
//
//  Created by 綦 on 16/9/19.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "UIViewController+MethodSwizzling.h"
#import <objc/objc-class.h>
#import "MainDefine.h"

@implementation UIViewController (MethodSwizzling)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class myClass = [self class];
        
        SEL oldSel = @selector(viewDidAppear:);
        SEL newSel = @selector(replaceViewDidAppear:);
        
        Method oldMethod = class_getInstanceMethod(myClass, oldSel);
        Method newMethod = class_getInstanceMethod(myClass, newSel);
        
        IMP newImp = method_getImplementation(newMethod);
        
        //class_addMethod会覆盖父类的方法实现，但不会取代本类中已存在的实现，如果本类中包含一个同名的实现，则函数会返回NO。
        BOOL added = class_addMethod(myClass, oldSel, newImp, method_getTypeEncoding(newMethod));
        //如果没有实现
        if (added) {
            //class_replaceMethod该函数的行为可以分为两种：如果类中不存在name指定的方法，则类似于class_addMethod函数一样会添加方法；如果类中已存在name指定的方法，则类似于method_setImplementation一样替代原方法的实现。
            class_replaceMethod(myClass, newSel, method_getImplementation(oldMethod), method_getTypeEncoding(newMethod));
        }
        else
        {
            //直接交换方法
            method_exchangeImplementations(oldMethod, newMethod);
        }
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
        [userDefaults setObject:dic forKey:Statistics_Controllers];
        [userDefaults synchronize];
    });
}

- (void)replaceViewDidAppear:(BOOL)animated
{
    [self replaceViewDidAppear:animated];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[userDefaults objectForKey:Statistics_Controllers]];
    NSString *className = NSStringFromClass([self class]);
    NSInteger index = [dic[className] integerValue] + 1;
    dic[className] = @(index);
    [userDefaults setObject:dic forKey:Statistics_Controllers];
    [userDefaults synchronize];
}

@end

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
        
        SEL oldSel = @selector(viewWillAppear:);
        SEL newSel = @selector(replaceViewWillApper:);
        
        Method oldMethod = class_getInstanceMethod(myClass, oldSel);
        Method newMethod = class_getInstanceMethod(myClass, newSel);
        
        IMP newImp = method_getImplementation(newMethod);
        
        BOOL added = class_addMethod(myClass, newSel, newImp, method_getTypeEncoding(newMethod));
        if (added) {
            class_replaceMethod(myClass, oldSel, newImp, method_getTypeEncoding(newMethod));
        }
        else
        {
            method_exchangeImplementations(oldMethod, newMethod);
        }
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
        [userDefaults setObject:dic forKey:Statistics_Controllers];
        [userDefaults synchronize];
    });
}

- (void)replaceViewWillApper:(BOOL)animated
{
    [self replaceViewWillApper:animated];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[userDefaults objectForKey:Statistics_Controllers]];
    NSString *className = NSStringFromClass([self class]);
    NSInteger index = [dic[className] integerValue] + 1;
    dic[className] = @(index);
    [userDefaults setObject:dic forKey:Statistics_Controllers];
    [userDefaults synchronize];
}

@end

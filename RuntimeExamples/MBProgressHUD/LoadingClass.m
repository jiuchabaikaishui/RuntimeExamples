//
//  LoadingClass.m
//  MyWeibo
//
//  Created by     -MINI on 16/2/25.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "LoadingClass.h"

#define Delay_Time  1.5
static LoadingClass *shareInstance;

@interface LoadingClass ()

@property (weak, nonatomic) MBProgressHUD *progressHud;
@property (weak, nonatomic) MBProgressHUD *successHud;
@property (weak, nonatomic) MBProgressHUD *messageHud;
@property (assign,nonatomic) NSInteger count;

@end

@implementation LoadingClass

+ (LoadingClass *)shareLoadingClass
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
        shareInstance.count = 0;
    });
    
    return shareInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [super allocWithZone:zone];
    });
    
    return shareInstance;
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)show
{
    return [self showMessage:@"正在加载中…"];
}
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    return [[self shareLoadingClass] showMessage:message toView:view];
}
+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}
- (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
//    if (self.successHud) {
//        [self.successHud hideAnimated:NO];
//    }
//    if (self.messageHud) {
//        [self.messageHud hideAnimated:NO];
//    }
    
    if (!self.count) {
        UIView *theView;
        if (view) {
            theView = view;
        }
        else
        {
            theView = [[UIApplication sharedApplication].windows lastObject];
        }
        
        self.progressHud = [MBProgressHUD showHUDAddedTo:theView animated:YES];
    }
    self.progressHud.label.text = message;
    self.count++;
    
    return self.progressHud;
}


+ (void)hideHUDForView:(UIView *)view
{
    NSInteger count = [self shareLoadingClass].count;
    if (count) {
        [self shareLoadingClass].count--;
    }
    count = [self shareLoadingClass].count;
    if ([self shareLoadingClass].count == 0) {
        [[self shareLoadingClass].progressHud hideAnimated:YES];
    }
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

+ (void)showSuccess
{
    [self showSuccess:YES andView:nil];
}
+ (void)showFailure
{
    [self showSuccess:NO andView:nil];
}
+ (void)showSuccess:(BOOL)success andView:(UIView *)view
{
    [[self shareLoadingClass] showSuccess:success andView:view];
}
- (void)showSuccess:(BOOL)success andView:(UIView *)view
{
    if (self.successHud) {
        [self.successHud hideAnimated:NO];
    }
    
    if (!view) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    
    self.successHud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    self.successHud.mode = MBProgressHUDModeCustomView;
    NSString *imageName = success ? @"CheckmarkS" : @"CheckmarkF";
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.successHud.customView = [[UIImageView alloc] initWithImage:image];
    self.successHud.square = YES;
    self.successHud.label.text = success ? @"成功！" : @"失败！";

    [self.successHud hideAnimated:YES afterDelay:Delay_Time];
}

+ (void)showMessageOnly:(NSString *)message
{
    [self showMessageOnly:message toView:[[UIApplication sharedApplication].windows lastObject]];
}
+ (void)showMessageOnly:(NSString *)message toView:(UIView *)view
{
    [[self shareLoadingClass] showMessageOnly:message toView:view];
}
- (void)showMessageOnly:(NSString *)message toView:(UIView *)view
{
    if (self.messageHud) {
        [self.messageHud hideAnimated:NO];
    }
    
    self.messageHud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    self.messageHud.mode = MBProgressHUDModeText;
    self.messageHud.label.text = message;
    self.messageHud.userInteractionEnabled = NO;
    //self.messageHud.offset = CGPointMake(0.f, MBProgressMaxOffset);

    [self.messageHud hideAnimated:YES afterDelay:Delay_Time];
}

@end

//
//  FirstExampleViewController.m
//  RuntimeExamples
//
//  Created by 綦 on 16/9/13.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "FirstExampleViewController.h"
#import "UIView+Tap.h"

//每行的视图个数
#define View_Row_Count              5
//总共的视图个数
#define View_Total_Count            10

@interface FirstExampleViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation FirstExampleViewController

#pragma mark - 控制器周期
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self settingUi];
}

#pragma mark - 自定义方法
/**
 *  设置UI
 */
- (void)settingUi
{
    CGFloat spacing = 8;
    CGFloat X;
    CGFloat Y;
    CGFloat W = ([UIScreen mainScreen].bounds.size.width - (View_Row_Count + 1)*spacing)/View_Row_Count;
    CGFloat H = W;
    CGRect rect;
    
    for (NSInteger index = 0; index < View_Total_Count; index++) {
        X = spacing + (index%View_Row_Count)*(W + spacing);
        Y = [UIScreen mainScreen].bounds.size.height/2 + spacing + (index/View_Row_Count)*(H + spacing);
        rect = CGRectMake(X, Y, W, H);
        
        UIView *view = [[UIView alloc] initWithFrame:rect];
        view.backgroundColor = [self randomColor];
        [view tapAction:^{
            view.backgroundColor = [self randomColor];
        }];
        [self.view addSubview:view];
    }
    
    [self.view tapAction:^{
        self.view.backgroundColor = [self randomColor];
    }];
    
    [self.label tapAction:^{
        self.label.backgroundColor = [self randomColor];
    }];
}
/**
 *  随机颜色
 *
 *  @return 颜色
 */
- (UIColor *)randomColor
{
    return [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1];
}

@end

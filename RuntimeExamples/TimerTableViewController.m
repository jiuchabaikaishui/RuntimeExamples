//
//  TimerTableViewController.m
//  RuntimeExamples
//
//  Created by 綦 on 16/9/18.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "TimerTableViewController.h"
#import "TimeModel.h"
#import "TimerCell.h"
#import <objc/Object.h>
#import "TimerTarget.h"

#define TableView_Row           100

@interface TimerTableViewController ()<TimerTargetDelegate>

@property (strong, nonatomic) NSMutableArray *dataArr;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation TimerTableViewController

#pragma mark - 属性方法
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray arrayWithCapacity:1];
        
        TimeModel *timeModel;
        for (NSInteger index = 0; index < TableView_Row; index++) {
            timeModel = [TimeModel timeModel:arc4random()%30 + 30];
            [_dataArr addObject:timeModel];
        }
    }
    
    return _dataArr;
}

#pragma mark - 控制器周期
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self settingUi];
}
- (void)dealloc
{
    //释放NSTimer的资源并置空NSTimer
    if (self.timer.isValid) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    NSLog(@"%@ 销毁了！", NSStringFromClass([self class]));
}

#pragma mark - 自定义方法
#define Timer_Key       "timer"
#define WeakSelf_Key    "weakSelf"
/**
 *  设置UI
 */
- (void)settingUi
{
    self.title = @"倒计时";
    
    NSTimer *timer;
    switch (self.type) {
        //产生内存泄漏
        case TimerTableViewControllerTypeMemoryLeak:
        {
            //NSTimer占用了self，如果不提前释放释放NSTimer占用的资源，就会造成self无法销毁，直到定时任务完成。
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        }
            break;
        //运行时解决内存泄漏
        case TimerTableViewControllerTypeRuntime:
        {
            //把NSTimer的Target对象设置为第三方对象
            NSObject *target = [[NSObject alloc] init];
            //为此对象动态添加方法
            class_addMethod([target class], @selector(timerAction:), (IMP)timerMethed, "V@:");
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:target selector:@selector(timerAction:) userInfo:nil repeats:YES];
            //为此对象动态添加属性，执行定时任务的对象与定时任务所需参数
            objc_setAssociatedObject(target, Timer_Key, timer, OBJC_ASSOCIATION_RETAIN);
            //此属性必须为弱引用，否则会引起循环引用
            objc_setAssociatedObject(target, WeakSelf_Key, self, OBJC_ASSOCIATION_ASSIGN);
        }
            break;
        //代理解决内存泄漏
        case TimerTableViewControllerTypeDelegate:
        {
            //把NSTimer的Target对象设置为第三方对象
            TimerTarget *timerTarget = [[TimerTarget alloc] init];
            timerTarget.delegate = self;
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:timerTarget selector:@selector(timerAction:) userInfo:nil repeats:YES];
        }
            break;
            
        default:
            break;
    }
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.timer = timer;
}

#pragma mark - 触摸点击方法
void timerMethed(id self, SEL _cmd)
{
    //取出定时任务的执行对象和参数
    id ctr = objc_getAssociatedObject(self, WeakSelf_Key);
    NSTimer *timer = objc_getAssociatedObject(self, Timer_Key);
    
    //执行定时任务
    [ctr performSelector:_cmd withObject:timer];
}
- (void)timerAction:(NSTimer *)timer
{
    //finished记录定时任务释放完成
    BOOL finished = YES;
    
    //执行定时任务
    for (TimeModel *timeModel in self.dataArr) {
        if (timeModel.time > 0) {
            timeModel.time--;
            finished = NO;
        }
    }
    
    //定时任务完成，释放NSTimer的资源并置空NSTimer
    if (finished) {
        [timer invalidate];
        timer = nil;
    }
}

#pragma mark - <TimerTargetDelegate>代理方法
- (void)timerTargetDelegate:(TimerTarget *)timerTarget
{
    [self timerAction:self.timer];
}

#pragma mark - <UITableView>代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimerCell *timerCell = [TimerCell timerCell:tableView];
    
    TimeModel *timeModel = self.dataArr[indexPath.row];
    timerCell.timeModel = timeModel;
    
    return timerCell;
}

@end

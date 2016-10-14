//
//  StatisticsTableViewController.m
//  RuntimeExamples
//
//  Created by 綦 on 16/9/19.
//  Copyright © 2016年 PowesunHolding. All rights reserved.
//

#import "StatisticsTableViewController.h"
#import "MainDefine.h"
#import "StatisticsModel.h"
#import "MJRefresh.h"
#import "LoadingClass.h"
#import <objc/objc-class.h>

@interface StatisticsTableViewController ()

@property (strong, nonatomic) NSMutableArray *dataArr;

@end

@implementation StatisticsTableViewController

#pragma amrk - 属性方法
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _dataArr;
}


#pragma amrk - 控制器周期
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self settingUi];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [LoadingClass show];
    [self gettingData:NO];
    
    __unsafe_unretained UITableView *tableView = self.tableView;
    __unsafe_unretained __typeof(self) weakSelf = self;
    
    // 下拉刷新
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf gettingData:YES];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.mj_header.automaticallyChangeAlpha = YES;
}

#pragma amrk - 自定义方法
- (void)settingUi
{
    self.title = @"页面统计";
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
- (void)gettingData:(BOOL)isWait
{
    if (isWait) {
        [LoadingClass show];
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic = [userDefaults objectForKey:Statistics_Controllers];
    NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:1];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        StatisticsModel *model = [[StatisticsModel alloc] init];
        model.name = key;
        model.count = [obj integerValue];
        [mArr addObject:model];
    }];
    
    self.dataArr = mArr;
    [self.tableView reloadData];
    
    [LoadingClass hideHUD];
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - <UITableViewDatasource, UITableViewDelegate>代理方法
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
    static NSString *cellIdentifier = @"StatisticsCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    
    StatisticsModel *model = self.dataArr[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@访问次数：%i", model.name, (int)model.count];
    
    return cell;
}

@end

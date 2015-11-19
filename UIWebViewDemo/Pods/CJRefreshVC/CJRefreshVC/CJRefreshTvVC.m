//
//  CJRefreshTvVC.m
//  CJRefreshVCDemo
//
//  Created by lichq on 15/11/2.
//  Copyright (c) 2015年 ciyouzen. All rights reserved.
//

#import "CJRefreshTvVC.h"
#import <MJRefresh/MJRefresh.h>

static const CGFloat M_Duration_Refresh = 0.1;
static const CGFloat M_Duration_Load = 0.1;



@interface CJRefreshTvVC ()

@end



@implementation CJRefreshTvVC
#pragma mark - 刷新动画的示例代码
#pragma mark UITableView 下拉刷新 + 上拉刷新 默认
- (void)example11
{
    __weak __typeof(self) weakSelf = self;
    
    
    //下拉刷新
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    //是否马上进入刷新状态：是
    [self.tableView.header beginRefreshing];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(M_Duration_Refresh * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.header beginRefreshing];
    });
    
    
    
    //上拉刷新
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    //    self.tableView.footer.automaticallyChangeAlpha = YES;//自动回弹的上拉02（隐藏"上拉加载“）
}


/*
 获取完数据后，在主线程dispatch_get_main_queue()中，进行[self.tableView reloadData];之后
 header有以下状态
 ①[self.tableView.header endRefreshing]; //结束刷新状态
 
 footer有以下状态
 ①[self.tableView.footer endRefreshing]; //结束刷新状态
 ②[self.tableView.footer noticeNoMoreData];//变为没有更多数据的状态（此时也结束了刷新的状态了）
 所以要想在下拉刷新之后，可以重新变成有更多数据需要进行如下设置
 [self.tableView.footer resetNoMoreData];
 */

#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    pageCur = 1; //pageCur从1开始
    
    [self loadNewData_2];
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(M_Duration_Load * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.header endRefreshing];
    });
    
    
    //注意：要加入以下代码resetNoMoreData，防止上拉加载全部之后，操作下拉刷新还是显示已加载全部数据
    [self.tableView.footer resetNoMoreData];
    
}

- (void)loadNewData_2{
    /*
    self.data = [NSMutableArray array];
    for (int i = 0; i<count_Per_Page; i++) {
        [self.data addObject:[NSString stringWithFormat:@"%d", arc4random()%100]];
    }
    */
}

- (void)loadMoreData_2{
    /*
    if (pageCur >= pageTotal) {
        NSLog(@"错误....");
        return;
    }
    if (pageCur == pageTotal - 1) {
        [self.data addObject:@"这是最后一份数据"];
        
    }else{
        for (int i = 0; i<count_Per_Page; i++) {
            [self.data addObject:[NSString stringWithFormat:@"更多数据%d", arc4random()%100]];
        }
    }
    pageCur ++;
    */
}

#pragma mark 上拉加载，更多数据
- (void)loadMoreData
{
    // 1.添加假数据
    [self loadMoreData_2];
    
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(M_Duration_Load * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        if (pageCur == pageTotal) { //上拉加载，最后一份数据
            // 拿到当前的上拉刷新控件，变为没有更多数据的状态
            [self.tableView.footer endRefreshingWithNoMoreData];//原本使用endRefreshingWithNoMoreData的方法别替换成这个了
        }else{
            // 拿到当前的上拉刷新控件，结束刷新状态
            [self.tableView.footer endRefreshing];
        }
        
    });
}

- (void)forceToRefreshData{
    [self.tableView.header beginRefreshing];
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self performSelector:@selector(example11) withObject:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    pageTotal = 4;
    count_Per_Page = 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    /*
    return self.data.count;
    */
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.row <= self.data.count-1) {
        cell.textLabel.text = [NSString stringWithFormat:@"%02d:page%d_____%@", indexPath.row, indexPath.row/count_Per_Page+1, self.data[indexPath.row]];
    }else{
        cell.textLabel.text = @"error";
    }
    
    return cell;
    */
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

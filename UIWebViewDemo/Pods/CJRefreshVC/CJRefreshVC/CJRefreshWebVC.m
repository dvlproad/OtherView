//
//  CJRefreshWebVC.m
//  CJRefreshVCDemo
//
//  Created by lichq on 15/11/2.
//  Copyright (c) 2015年 ciyouzen. All rights reserved.
//

#import "CJRefreshWebVC.h"
#import <MJRefresh/MJRefresh.h>

@interface CJRefreshWebVC ()

@end

@implementation CJRefreshWebVC

#pragma mark - 示例
- (void)example31
{
    __weak UIWebView *webView = self.webV;
    webView.delegate = self;
    
    __weak UIScrollView *scrollView = self.webV.scrollView;
    
    // 添加下拉刷新控件
    scrollView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [webView reload];
    }];
    
    // 如果是上拉刷新，就以此类推
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [super webViewDidFinishLoad:webView];
    
    [self.webV.scrollView.header endRefreshing];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [super webView:webView didFailLoadWithError:error];
    
    [self.webV.scrollView.header endRefreshing];
}

- (void)forceToRefreshData{
    [self.webV.scrollView.header beginRefreshing];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self performSelector:@selector(example31) withObject:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

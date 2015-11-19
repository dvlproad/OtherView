//
//  CJRefreshTvVC.h
//  CJRefreshVCDemo
//
//  Created by lichq on 15/11/2.
//  Copyright (c) 2015年 ciyouzen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJRefreshTvVC : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    NSInteger pageCur;
    NSInteger pageTotal;
    NSInteger count_Per_Page;
}
@property(nonatomic, strong) NSMutableArray *data;
@property(nonatomic, strong) IBOutlet UITableView *tableView;

- (void)loadNewData_2;
- (void)loadMoreData_2;

- (void)forceToRefreshData;

@end

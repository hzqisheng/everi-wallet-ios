//
//  QSBaseTableViewController.h
//  QSSmarkPark-iOS
//
//  Created by 孙俊 on 2018/4/2.
//  Copyright © 2018年 QiSheng. All rights reserved.
//

#import "QSBaseViewController.h"

@protocol RefreshDataManager <NSObject>

@optional
/** 上拉下拉触发刷新方法 */
- (void)tableViewShouldUpdateDataByPageIndex:(NSInteger)pageIndex;

@end

@interface QSBaseTableViewController : QSBaseViewController<UITableViewDelegate,UITableViewDataSource, RefreshDataManager>

/** 样式 默认是UITableViewStylePlain*/
@property(nonatomic, assign) UITableViewStyle style;

/** tableview */
@property(nonatomic, strong) UITableView *tableView;

/** 数据源 */
@property(nonatomic, strong) NSMutableArray *dataArray;

/** 页码 默认是1 */
@property(nonatomic, assign, readonly) NSInteger pageIndex;

/** 添加下拉刷新 */
- (void)addRefreshHeader;

/** 添加上拉刷新 */
- (void)addRefreshFooter;

/** 结束刷新 */
- (void)endRefreshing;

/** 结束刷新 footer显示没有更多 */
- (void)endRefreshingWithNoMoreData;

/** 刷新数据 */
- (void)startRefreshing;

/** 刷新数据 是否有动画*/
- (void)startRefreshing:(BOOL)animated;

@end

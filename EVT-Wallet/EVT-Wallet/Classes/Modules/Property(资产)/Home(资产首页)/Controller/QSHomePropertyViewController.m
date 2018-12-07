//
//  QSHomePropertyViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/23.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSHomePropertyViewController.h"
#import "QSHomeMyFTsViewController.h"
#import "QSHomeMyNFTsViewController.h"
#import "QSCollectCodeViewController.h"
#import "QSEveriPayCodeViewController.h"
#import "QSScanningViewController.h"

#import "QSPropetyHomeSwipeView.h"
#import "QSPropertyHomeSwipeCell.h"
#import "QSPropetyHomeSegmentView.h"
#import "QSPropetyHomeShortcutView.h"

@interface QSHomePropertyViewController ()
<QSSwipeDelegate,
QSPropetyHomeShortcutViewDelegate,
QSPropetyHomeSegmentViewDelegate,
UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) QSPropetyHomeSwipeView *swipeView;
@property (nonatomic, strong) QSPropetyHomeShortcutView *shortcutView;
@property (nonatomic, strong) QSPropetyHomeSegmentView *segmentView;

@property (nonatomic, strong) QSHomeMyFTsViewController *myFTsViewController;
@property (nonatomic, strong) QSHomeMyNFTsViewController *myNFTsViewController;

@property (nonatomic, assign) CGFloat headerViewHeight;

@end

@implementation QSHomePropertyViewController

#pragma mark - **************** Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    [self setupScrollView];
    [self setupHeaderView];
    [self setupChildViewControllers];
}

#pragma mark - **************** Initials
- (void)setupHeaderView {
    [self.headerView addSubview:self.swipeView];
    [self.headerView addSubview:self.shortcutView];
    [self.headerView addSubview:self.segmentView];

    [self.swipeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.headerView);
        make.height.equalTo(@(kHomeSwipeViewH));
    }];
    
    [self.shortcutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.swipeView.mas_bottom).offset(-kHomeShortcutViewH/2);
        make.centerX.equalTo(self.headerView);
        make.size.mas_equalTo(CGSizeMake(kHomeShortcutViewW, kHomeShortcutViewH));
    }];
    
    [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shortcutView.mas_bottom).offset(kHomeSegmentViewTopMargin);
        make.left.and.right.equalTo(self.headerView);
        make.height.equalTo(@(kHomeSegmentViewH));
    }];
}

- (void)setupScrollView {
    [self.view addSubview:self.scrollView];
    self.scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabBarHeight);
    
    [self.view addSubview:self.headerView];
    self.headerView.frame = CGRectMake(0, 0, kScreenWidth, kHomeHeaderViewHeight);
}

- (void)setupChildViewControllers {
    [self addChildViewController:self.myFTsViewController];
    self.myFTsViewController.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabBarHeight);
    [self.myFTsViewController beginAppearanceTransition:YES animated:YES];
    [self.scrollView addSubview:self.myFTsViewController.view];
    [self.myFTsViewController endAppearanceTransition];
    [self.myFTsViewController.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionInitial context:nil];
    
    [self addChildViewController:self.myNFTsViewController];
    self.myNFTsViewController.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight - kTabBarHeight);
    [self.myNFTsViewController beginAppearanceTransition:YES animated:YES];
    [self.scrollView addSubview:self.myNFTsViewController.view];
    [self.myNFTsViewController endAppearanceTransition];
    [self.myNFTsViewController.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionInitial context:nil];
}

#pragma mark - **************** KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        UITableView *tableView = object;
        CGFloat contentOffsetY = tableView.contentOffset.y;
        
        CGFloat headerInfoH = kHomeHeaderViewHeight - kHomeSegmentViewH;
        // 如果滑动没有超过headerInfoH
        if (contentOffsetY < headerInfoH) {
            // 让tableView的偏移量相等
            for (QSBaseTableViewController *vc in self.childViewControllers) {
                if (vc.tableView.contentOffset.y != tableView.contentOffset.y) {
                    vc.tableView.contentOffset = tableView.contentOffset;
                }
            }
            CGFloat headerY = -tableView.contentOffset.y;
            self.headerView.y = headerY;
        } else if (contentOffsetY >= headerInfoH) {
            // 一旦大于等于headerInfoH了，让headerView的y值等于headerInfoH，就停留在上边了
            self.headerView.y = -headerInfoH;
        }
    }
}

#pragma mark - **************** QSSwipeDelegate
- (UITableViewCell *)swipeView:(QSPropetyHomeSwipeView *)swipeView CellAtIndex:(NSInteger)index {
    static NSString *identify = @"swipeCellIndentify";
    QSPropertyHomeSwipeCell * cell = (QSPropertyHomeSwipeCell *)[swipeView dequeueReusableUIViewWithIdentifier:identify];
    if (cell == nil) {
        cell = [[QSPropertyHomeSwipeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    return cell;
}

- (NSInteger)numberOfCellInSwipeView:(QSPropetyHomeSwipeView *)swipeView {
    return 3;
}

- (CGSize)sizeForPerCellInSwipeView:(QSPropetyHomeSwipeView *)swipeView {
    return CGSizeMake(kRealValue(340), kRealValue(100));
}

#pragma mark - **************** QSPropetyHomeShortcutViewDelegate
- (void)shortcutView:(QSPropetyHomeShortcutView *)shortcutView didClickedItemByType:(QSShortcutType)type {
    if (type == QSShortcutTypeCollect) {
        QSCollectCodeViewController *collect = [[QSCollectCodeViewController alloc] init];
        collect.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:collect animated:YES];
    } else if (type == QSShortcutTypeEveriPay) {
        QSEveriPayCodeViewController *everiPay = [[QSEveriPayCodeViewController alloc] init];
        everiPay.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:everiPay animated:YES];
    } else if (type == QSShortcutTypeScan) {
        QSScanningViewController *scan = [[QSScanningViewController alloc] init];
        scan.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:scan animated:YES];
    }
}

#pragma mark - **************** QSPropetyHomeSegmentViewDelegate
- (void)segmentView:(QSPropetyHomeSegmentView *)segmentView didClickedAtIndex:(NSInteger)index {
    DLog(@"点击index%ld",(long)index);
    self.scrollView.contentOffset = CGPointMake(index * kScreenWidth, 0);
}

#pragma mark - **************** UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == 0) {
        self.segmentView.currentIndex = 0;
    } else if (scrollView.contentOffset.x == kScreenWidth) {
        self.segmentView.currentIndex = 1;
    }
}

#pragma mark - **************** Setter Getter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.contentSize = CGSizeMake(kScreenWidth * 2, 0);
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

- (QSPropetyHomeSwipeView *)swipeView {
    if (!_swipeView) {
        _swipeView = [[QSPropetyHomeSwipeView alloc] init];
        _swipeView.backgroundColor = [UIColor grayColor];
        _swipeView.isStackCard = YES;
        _swipeView.delegate = self;
    }
    return _swipeView;
}

- (QSPropetyHomeShortcutView *)shortcutView {
    if (!_shortcutView) {
        _shortcutView = [[QSPropetyHomeShortcutView alloc] init];
        _shortcutView.delegate = self;
    }
    return _shortcutView;
}

- (QSPropetyHomeSegmentView *)segmentView {
    if (!_segmentView) {
        _segmentView = [[QSPropetyHomeSegmentView alloc] init];
        _segmentView.delegate = self;
    }
    return _segmentView;
}

- (QSHomeMyFTsViewController *)myFTsViewController {
    if (!_myFTsViewController) {
        _myFTsViewController = [[QSHomeMyFTsViewController alloc] init];
    }
    return _myFTsViewController;
}

- (QSHomeMyNFTsViewController *)myNFTsViewController {
    if (!_myNFTsViewController) {
        _myNFTsViewController = [[QSHomeMyNFTsViewController alloc] init];
    }
    return _myNFTsViewController;
}

- (void)dealloc {
    for (QSBaseTableViewController *tableVC in self.childViewControllers) {
        [tableVC.tableView removeObserver:self forKeyPath:@"contentOffset"];
    }
}

@end

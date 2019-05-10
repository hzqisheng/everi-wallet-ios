//
//  QSMyGroupViewController.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/13.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSMyGroupViewController.h"
#import "QSManageMyGroupCell.h"
#import "QSManageMyGroupItem.h"
#import "QSCreateGroupViewController.h"
#import "QSEveriApiWebViewController.h"
#import "QSMyGroupDetailViewController.h"

@interface QSMyGroupViewController ()

@property (nonatomic, strong) UIButton *createButton;

@end

@implementation QSMyGroupViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_manage_mineGroup_title")];
    [self setupBottomButton];
    [self setupTableView];
    [self addRefreshHeader];
}

- (void)setupTableView {
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.height = kScreenHeight - kNavgationBarHeight - kRealValue(60) - self.createButton.height - kiPhoneXSafeAreaBottomMagin;
}

- (void)setupBottomButton {
    UIButton *bottomButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_manage_createGroup_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(bottomButtonClicked)];
    [bottomButton setImage:[UIImage imageNamed:@"icon_xuanzedaibi_plus"] forState:UIControlStateNormal];
    bottomButton.backgroundColor = [UIColor qs_colorBlack313745];
    bottomButton.layer.cornerRadius = 2;
    bottomButton.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
    bottomButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4);
    [self.view addSubview:bottomButton];
    CGFloat bottomButtonBottomMargin = kDevice_Is_iPhoneX ? kiPhoneXSafeAreaBottomMagin : kRealValue(15);
    [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-bottomButtonBottomMargin);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kBottomButtonWidth, kBottomButtonHeight));
    }];
    self.createButton = bottomButton;
}

- (void)tableViewShouldUpdateDataByPageIndex:(NSInteger)pageIndex {
    [[QSEveriApiWebViewController sharedWebView] getManagedGroupsAndCompeleteBlock:^(NSInteger statusCode, NSArray * _Nullable data) {
        if (statusCode == kResponseSuccessCode) {
            if (self.dataArray.count) {
                [self.dataArray removeAllObjects];
            }
            
            for (NSDictionary *dic in data) {
                QSManageMyGroupItem *group = [[QSManageMyGroupItem alloc] init];
                group.title = dic[@"name"];
                group.cellHeight = kRealValue(51);
                group.cellIdentifier = NSStringFromClass([QSManageMyGroupCell class]);
                [self.dataArray addObject:group];
            }
            
            [self.tableView reloadData];
        }
        [self endRefreshing];
    }];
}

#pragma mark - **************** Event Response
- (void)bottomButtonClicked {
    QSCreateGroupViewController *vc = [[QSCreateGroupViewController alloc] init];
    [vc setupNavgationBarTitle:QSLocalizedString(@"qs_manage_createGroup_title")];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - **************** QSBaseCornerSectionTableViewControllerProtocol
- (NSArray<QSBaseCellItem *> *)createSingleSectionDataSource {
    return self.dataArray;
}

#pragma mark - **************** UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QSManageMyGroupItem *group = self.dataArray[indexPath.row];
    
    QSMyGroupDetailViewController *detail = [[QSMyGroupDetailViewController alloc] init];
    detail.groupName = group.title;
    [self.navigationController pushViewController:detail animated:YES];
}

@end

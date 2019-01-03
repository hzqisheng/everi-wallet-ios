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

@interface QSMyGroupViewController ()

@property (nonatomic, strong) UIButton *createButton;

@end

@implementation QSMyGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_manage_mineGroup_title")];
    [self setupBottomButton];
    [self setupTableView];
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

#pragma mark - **************** Event Response
- (void)bottomButtonClicked {
    QSCreateGroupViewController *vc = [[QSCreateGroupViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - **************** QSBaseCornerSectionTableViewControllerProtocol
- (Class)getRigisterCellClass {
    return [QSManageMyGroupCell class];
}

- (NSArray<NSArray<QSBaseCellItem *> *> *)createMultiSectionDataSource {
    QSManageMyGroupItem *groupOne = [[QSManageMyGroupItem alloc] init];
    groupOne.title = @"我的一组";
    groupOne.cellHeight = kRealValue(51);
    groupOne.cellIdentifier = NSStringFromClass([QSManageMyGroupCell class]);
    
    QSManageMyGroupItem *groupTwo = [[QSManageMyGroupItem alloc] init];
    groupTwo.title = @"我的二组";
    groupTwo.cellHeight = kRealValue(51);
    groupTwo.cellIdentifier = NSStringFromClass([QSManageMyGroupCell class]);
    
    QSManageMyGroupItem *groupThree = [[QSManageMyGroupItem alloc] init];
    groupThree.title = @"我的三组";
    groupThree.cellHeight = kRealValue(51);
    groupThree.cellIdentifier = NSStringFromClass([QSManageMyGroupCell class]);
    
    return @[@[groupOne,groupTwo,groupThree]];
}

#pragma mark - **************** UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end

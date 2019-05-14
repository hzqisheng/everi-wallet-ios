//
//  QSManagerSelectAddressViewController.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/14.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSManagerSelectAddressViewController.h"
#import "QSManageSelectAddressCell.h"
#import "QSManageSelectAddressItem.h"

@interface QSManagerSelectAddressViewController ()

@property (nonatomic, strong) UIButton *allSelectedButton;
@property (nonatomic, strong) UILabel *allSelectedLabel;
@property (nonatomic, strong) UIButton *leftBottomButton;
@property (nonatomic, strong) UIButton *rightBottomButton;

@end

@implementation QSManagerSelectAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_manage_address_nav_title")];
    [self setupTableView];
    [self loadUI];
}

- (void)setupTableView {
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.height = kScreenHeight - kNavgationBarHeight - kRealValue(80);
}

- (void)loadUI {
    [self.allSelectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kRealValue(16));
        make.bottom.equalTo(self.view).offset(-kRealValue(17) - kiPhoneXSafeAreaBottomMagin);
        make.size.mas_equalTo(CGSizeMake(kRealValue(16), kRealValue(16)));
    }];
    
    [self.allSelectedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.allSelectedButton);
        make.left.equalTo(self.allSelectedButton.mas_right).offset(kRealValue(10));
        make.height.equalTo(@kRealValue(15));
    }];
    
    [self.leftBottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-kiPhoneXSafeAreaBottomMagin);
        make.right.equalTo(self.rightBottomButton.mas_left);
        make.height.equalTo(@kRealValue(49));
    }];
    
    [self.rightBottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.centerY.equalTo(self.leftBottomButton);
        make.size.mas_equalTo(CGSizeMake(kRealValue(120), kRealValue(49)));
    }];
}


#pragma mark - **************** Event Response
- (void)leftBottomButtonClicked {
    self.allSelectedButton.selected = !self.allSelectedButton.selected;
    for (int i = 0; i < 3; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        QSManageSelectAddressItem *selectItem = (QSManageSelectAddressItem *)[self itemInIndexPath:indexPath];
        selectItem.isSelected = self.allSelectedButton.selected;
    }
    [self.tableView reloadData];
}

- (void)rightBottomButtonClicked {
    
}

#pragma mark - **************** QSBaseCornerSectionTableViewControllerProtocol
- (NSArray<NSArray<id<QSBaseCellItemDataProtocol>> *> *)createMultiSectionDataSource {
    QSManageSelectAddressItem *item1 = [[QSManageSelectAddressItem alloc] init];
    item1.title = @"EVT8LJq6...caQkAySesdfsdfsf";
    item1.content = @"钱钱钱";
    
    QSManageSelectAddressItem *item2 = [[QSManageSelectAddressItem alloc] init];
    item2.title = @"EVT8LJq6...caQkAySesdfsdfsf";
    item2.content = @"钱钱钱";
    
    QSManageSelectAddressItem *item3 = [[QSManageSelectAddressItem alloc] init];
    item3.title = @"EVT8LJq6...caQkAySesdfsdfsf";
    item3.content = @"钱钱钱";
    
    return @[@[item1,item2,item3]];
}

#pragma mark - **************** UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QSManageSelectAddressItem *selectItem = (QSManageSelectAddressItem *)[self itemInIndexPath:indexPath];
    selectItem.isSelected = !selectItem.isSelected;
    [self.tableView reloadData];
}

#pragma mark - **************** Setter Getter
- (UIButton *)allSelectedButton {
    if (!_allSelectedButton) {
        _allSelectedButton = [[UIButton alloc] init];
        [_allSelectedButton setImage:[UIImage imageNamed:@"icon_quanxianshezhi_unselected"] forState:UIControlStateNormal];
        [_allSelectedButton setImage:[UIImage imageNamed:@"icon_quanxianbianji_selected"] forState:UIControlStateSelected];
        [self.view addSubview:_allSelectedButton];
    }
    return _allSelectedButton;
}

- (UILabel *)allSelectedLabel {
    if (!_allSelectedLabel) {
        _allSelectedLabel = [[UILabel alloc] init];
        _allSelectedLabel.text = QSLocalizedString(@"qs_manage_createGroup_allSelect");
        _allSelectedLabel.font = [UIFont qs_fontOfSize15];
        _allSelectedLabel.textColor = [UIColor qs_colorBlack333333];
        [self.view addSubview:_allSelectedLabel];
    }
    return _allSelectedLabel;
}

- (UIButton *)leftBottomButton {
    if (!_leftBottomButton) {
        _leftBottomButton = [[UIButton alloc] init];
        _leftBottomButton.backgroundColor = [UIColor clearColor];
        _leftBottomButton.layer.borderWidth = BORDER_WIDTH_1PX;
        _leftBottomButton.layer.borderColor = [UIColor qs_colorBlack313745].CGColor;
        [_leftBottomButton addTarget:self action:@selector(leftBottomButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_leftBottomButton];
    }
    return _leftBottomButton;
}

- (UIButton *)rightBottomButton {
    if (!_rightBottomButton) {
        _rightBottomButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_manage_createGroup_confirm") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(rightBottomButtonClicked)];
        _rightBottomButton.backgroundColor = [UIColor qs_colorBlack313745];
        [self.view addSubview:_rightBottomButton];
    }
    return _rightBottomButton;
}

@end

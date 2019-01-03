//
//  QSCreateGroupViewController.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/13.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSCreateGroupViewController.h"
#import "QSManageNewNodeViewController.h"
#import "QSManagerSelectAddressViewController.h"
#import "QSEnterPublicKeyViewController.h"
#import "QSEnterJsonViewController.h"
#import "QSManagerSettingView.h"

@interface QSCreateGroupViewController ()

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UIView *nameLine;

@property (nonatomic, strong) UILabel *managerLabel;
@property (nonatomic, strong) UIButton *managerButton;
@property (nonatomic, strong) UIView *managerLine;

@property (nonatomic, strong) UILabel *groupStructureLabel;
@property (nonatomic, strong) UIButton *groupButton;
@property (nonatomic, strong) UIView *structureLine;

@property (nonatomic, strong) UILabel *thresholdLabel;
@property (nonatomic, strong) UIButton *subtractButton;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UIView *sholdLine;

@property (nonatomic, strong) UILabel *nodeLabel;
@property (nonatomic, strong) UIButton *nodeButton;

@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation QSCreateGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_manage_createGroup_title")];
    [self loadUI];
}

- (void)loadUI {
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(kRealValue(15));
        make.height.equalTo(@kRealValue(277));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(kRealValue(20));
        make.top.equalTo(self.whiteView).offset(kRealValue(20));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.whiteView).offset(-kRealValue(20));
        make.centerY.equalTo(self.nameLabel);
        make.left.equalTo(self.nameLabel.mas_right).offset(kRealValue(20));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.nameLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(kRealValue(20));
        make.right.equalTo(self.whiteView).offset(-kRealValue(20));
        make.top.equalTo(self.nameLabel.mas_bottom).offset(kRealValue(20));
        make.height.equalTo(@BORDER_WIDTH_1PX);
    }];
    
    [self.managerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(kRealValue(20));
        make.top.equalTo(self.nameLine.mas_bottom).offset(kRealValue(20));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.managerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.whiteView).offset(-kRealValue(20));
        make.centerY.equalTo(self.managerLabel);
        make.left.equalTo(self.managerLabel.mas_right).offset(kRealValue(20));
        make.height.equalTo(@kRealValue(20));
    }];
    
    [self.managerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(kRealValue(20));
        make.right.equalTo(self.whiteView).offset(-kRealValue(20));
        make.top.equalTo(self.managerLabel.mas_bottom).offset(kRealValue(20));
        make.height.equalTo(@BORDER_WIDTH_1PX);
    }];
    
    [self.groupStructureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(kRealValue(20));
        make.top.equalTo(self.managerLine.mas_bottom).offset(kRealValue(20));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.groupButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.whiteView).offset(-kRealValue(20));
        make.centerY.equalTo(self.groupStructureLabel);
        make.left.equalTo(self.groupStructureLabel.mas_right).offset(kRealValue(20));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.structureLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(kRealValue(20));
        make.right.equalTo(self.whiteView).offset(-kRealValue(20));
        make.top.equalTo(self.groupStructureLabel.mas_bottom).offset(kRealValue(20));
        make.height.equalTo(@BORDER_WIDTH_1PX);
    }];
    
    [self.thresholdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(kRealValue(20));
        make.top.equalTo(self.structureLine.mas_bottom).offset(kRealValue(20));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.subtractButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.countLabel.mas_left);
        make.centerY.equalTo(self.thresholdLabel);
        make.size.mas_equalTo(CGSizeMake(kRealValue(24), kRealValue(24)));
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.whiteView).offset(-kRealValue(20));
        make.centerY.equalTo(self.thresholdLabel);
        make.size.mas_equalTo(CGSizeMake(kRealValue(24), kRealValue(24)));
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.addButton.mas_left);
        make.centerY.equalTo(self.thresholdLabel);
        make.size.mas_equalTo(CGSizeMake(kRealValue(24), kRealValue(24)));
    }];
    
    [self.sholdLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(kRealValue(20));
        make.right.equalTo(self.whiteView).offset(-kRealValue(20));
        make.top.equalTo(self.thresholdLabel.mas_bottom).offset(kRealValue(20));
        make.height.equalTo(@BORDER_WIDTH_1PX);
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteView.mas_bottom).offset(30);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - kRealValue(30), kRealValue(40)));
    }];
    
    [self.nodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(kRealValue(20));
        make.top.equalTo(self.sholdLine.mas_bottom).offset(kRealValue(20));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.nodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.whiteView).offset(-kRealValue(25));
        make.centerY.equalTo(self.nodeLabel);
        make.size.mas_equalTo(CGSizeMake(kRealValue(23), kRealValue(23)));
    }];
}

#pragma mark - **************** Event Response
- (void)bottomButtonClicked {
    
}

- (void)setManagerAction {
    WeakSelf(weakSelf);
    [QSManagerSettingView showManagerSettingViewWithTag:self.managerButton.tag andEditBlock:^{
        [weakSelf.managerButton setTitle:QSLocalizedString(@"qs_manage_createGroup_manager_State1") forState:UIControlStateNormal];
        weakSelf.managerButton.tag = 1;
        } andSelectBlock:^{
            [weakSelf goToSelectAddressVC];
        } andEnterKeyBlock:^{
            [weakSelf goToEnterPublicyKeyVC];
        }];
}

- (void)goToSelectAddressVC {
    QSManagerSelectAddressViewController *selectVC = [[QSManagerSelectAddressViewController alloc] init];
//    weakSelf.managerButton.tag = 2;
//    [weakSelf.managerButton setTitle:QSLocalizedString(@"qs_manage_createGroup_manager_State2") forState:UIControlStateNormal];
    [self.navigationController pushViewController:selectVC animated:YES];
}

- (void)goToEnterPublicyKeyVC {
    QSEnterPublicKeyViewController *enterVC = [[QSEnterPublicKeyViewController alloc] init];
    WeakSelf(weakSelf);
    enterVC.enterPublicKeyViewControllerSaveBlock = ^(NSString * _Nonnull text) {
        if (text.length) {
            weakSelf.managerButton.tag = 3;
            [weakSelf.managerButton setTitle:QSLocalizedString(@"qs_manage_createGroup_manager_State3") forState:UIControlStateNormal];
        }
    };
    [self.navigationController pushViewController:enterVC animated:YES];
}

- (void)goToGroupVC {
    QSEnterJsonViewController *jsonVC = [[QSEnterJsonViewController alloc] init];
    [self.navigationController pushViewController:jsonVC animated:YES];
}

- (void)subtractAction {
    if ([self.countLabel.text integerValue] > 1) {
        self.countLabel.text = [NSString stringWithFormat:@"%ld",[self.countLabel.text integerValue] - 1];
    }
}

- (void)addAction {
    if ([self.countLabel.text integerValue] < 10) {
        self.countLabel.text = [NSString stringWithFormat:@"%ld",[self.countLabel.text integerValue] + 1];
    }
}

- (void)addNodeAction {
    QSManageNewNodeViewController *nodeVC = [[QSManageNewNodeViewController alloc] init];
    [self.navigationController pushViewController:nodeVC animated:YES];
}

#pragma mark - **************** Setter Getter
- (UIView *)whiteView {
    if (!_whiteView) {
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
        _whiteView.layer.cornerRadius = kRealValue(8);
        [self.view addSubview:_whiteView];
    }
    return _whiteView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = QSLocalizedString(@"qs_add_address_item_name_title");
        _nameLabel.textColor = [UIColor qs_colorBlack333333];
        _nameLabel.font = [UIFont qs_fontOfSize14];
        [self.whiteView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UITextField *)nameTextField {
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] init];
        _nameTextField.placeholder = QSLocalizedString(@"qs_add_address_item_name_placeholder");
        _nameTextField.textColor = [UIColor qs_colorBlack333333];
        _nameTextField.font = [UIFont qs_fontOfSize14];
        [_nameTextField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
        [_nameTextField setValue:[UIFont qs_fontOfSize14] forKeyPath:@"_placeholderLabel.font"];
        _nameTextField.textAlignment = NSTextAlignmentRight;
        [self.whiteView addSubview:_nameTextField];
    }
    return _nameTextField;
}

- (UIView *)nameLine {
    if (!_nameLine) {
        _nameLine = [[UIView alloc] init];
        _nameLine.backgroundColor = [UIColor qs_colorGrayDDDDDD];
        [self.whiteView addSubview:_nameLine];
    }
    return _nameLine;
}

- (UILabel *)managerLabel {
    if (!_managerLabel) {
        _managerLabel = [[UILabel alloc] init];
        _managerLabel.text = QSLocalizedString(@"qs_manage_createGroup_managers");
        _managerLabel.textColor = [UIColor qs_colorBlack333333];
        _managerLabel.font = [UIFont qs_fontOfSize14];
        [self.whiteView addSubview:_managerLabel];
    }
    return _managerLabel;
}

- (UIButton *)managerButton {
    if (!_managerButton) {
        _managerButton = [[UIButton alloc] init];
        [_managerButton setTitle:QSLocalizedString(@"qs_manage_createGroup_manager_State1") forState:UIControlStateNormal];
        _managerButton.tag = 1;
        [_managerButton setTitleColor:[UIColor qs_colorGrayBBBBBB] forState:UIControlStateNormal];
        _managerButton.titleLabel.font = [UIFont qs_fontOfSize14];
        [_managerButton addTarget:self action:@selector(setManagerAction) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteView addSubview:_managerButton];
    }
    return _managerButton;
}

- (UIView *)managerLine {
    if (!_managerLine) {
        _managerLine = [[UIView alloc] init];
        _managerLine.backgroundColor = [UIColor qs_colorGrayDDDDDD];
        [self.whiteView addSubview:_managerLine];
    }
    return _managerLine;
}

- (UILabel *)groupStructureLabel {
    if (!_groupStructureLabel) {
        _groupStructureLabel = [[UILabel alloc] init];
        _groupStructureLabel.text = QSLocalizedString(@"qs_manage_createGroup_structure");
        _groupStructureLabel.textColor = [UIColor qs_colorBlack333333];
        _groupStructureLabel.font = [UIFont qs_fontOfSize14];
        [self.whiteView addSubview:_groupStructureLabel];
    }
    return _groupStructureLabel;
}

- (UIButton *)groupButton {
    if (!_groupButton) {
        _groupButton = [[UIButton alloc] init];
        [_groupButton setTitle:QSLocalizedString(@"qs_manage_createGroup_structure_placeholder") forState:UIControlStateNormal];
        [_groupButton setTitleColor:[UIColor qs_colorGrayBBBBBB] forState:UIControlStateNormal];
        _groupButton.titleLabel.font = [UIFont qs_fontOfSize14];
        _groupButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [_groupButton addTarget:self action:@selector(goToGroupVC) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteView addSubview:_groupButton];
    }
    return _groupButton;
}

- (UIView *)structureLine {
    if (!_structureLine) {
        _structureLine = [[UIView alloc] init];
        _structureLine.backgroundColor = [UIColor qs_colorGrayDDDDDD];
        [self.whiteView addSubview:_structureLine];
    }
    return _structureLine;
}

- (UILabel *)thresholdLabel {
    if (!_thresholdLabel) {
        _thresholdLabel = [[UILabel alloc] init];
        _thresholdLabel.text = QSLocalizedString(@"qs_manage_createGroup_threshold");
        _thresholdLabel.textColor = [UIColor qs_colorBlack333333];
        _thresholdLabel.font = [UIFont qs_fontOfSize14];
        [self.whiteView addSubview:_thresholdLabel];
    }
    return _thresholdLabel;
}

- (UIButton *)subtractButton {
    if (!_subtractButton) {
        _subtractButton = [[UIButton alloc] init];
        [_subtractButton setImage:[UIImage imageNamed:@"icon_wodeyu_minus"] forState:UIControlStateNormal];
        [_subtractButton addTarget:self action:@selector(subtractAction) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteView addSubview:_subtractButton];
    }
    return _subtractButton;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [[UIButton alloc] init];
        [_addButton setImage:[UIImage imageNamed:@"icon_wodeyu_plus"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteView addSubview:_addButton];
    }
    return _addButton;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.text = @"1";
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.textColor = [UIColor qs_colorGray686868];
        _countLabel.font = [UIFont qs_fontOfSize14];
        [self.whiteView addSubview:_countLabel];
    }
    return _countLabel;
}

- (UIView *)sholdLine {
    if (!_sholdLine) {
        _sholdLine = [[UIView alloc] init];
        _sholdLine.backgroundColor = [UIColor qs_colorGrayDDDDDD];
        [self.whiteView addSubview:_sholdLine];
    }
    return _sholdLine;
}

- (UILabel *)nodeLabel {
    if (!_nodeLabel) {
        _nodeLabel = [[UILabel alloc] init];
        _nodeLabel.text = QSLocalizedString(@"qs_manage_createGroup_node");
        _nodeLabel.textColor = [UIColor qs_colorBlack333333];
        _nodeLabel.font = [UIFont qs_fontOfSize14];
        [self.whiteView addSubview:_nodeLabel];
    }
    return _nodeLabel;
}

- (UIButton *)nodeButton {
    if (!_nodeButton) {
        _nodeButton = [[UIButton alloc] init];
        [_nodeButton setImage:[UIImage imageNamed:@"icon_wodeyu_plus1"] forState:UIControlStateNormal];
        [_nodeButton addTarget: self action:@selector(addNodeAction) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteView addSubview:_nodeButton];
    }
    return _nodeButton;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_select_ft_btn_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize14] taget:self action:@selector(bottomButtonClicked)];
        _submitButton.backgroundColor = [UIColor qs_colorBlack313745];
        _submitButton.layer.cornerRadius = 2;
        [self.view addSubview:_submitButton];
    }
    return _submitButton;
}


@end

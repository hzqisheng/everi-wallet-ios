//
//  QSManageNewNodeViewController.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/14.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSManageNewNodeViewController.h"

@interface QSManageNewNodeViewController ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *rightArrowButton;

@property (nonatomic, strong) UILabel *keyLabel;
@property (nonatomic, strong) UITextField *manageTextField;
@property (nonatomic, strong) UIButton *sweepButton;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *weightLabel;
@property (nonatomic, strong) UIButton *subtractButton;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation QSManageNewNodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_manage_createGroup_NewNode")];
    [self loadUI];
}

- (void)loadUI {
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.right.equalTo(self.view).offset(-kRealValue(15));
        make.top.equalTo(self.view).offset(kRealValue(15));
        make.height.equalTo(@kRealValue(45));
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.right.equalTo(self.view).offset(-kRealValue(15));
        make.top.equalTo(self.topView.mas_bottom).offset(kRealValue(10));
        make.height.equalTo(@kRealValue(91));
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView.mas_bottom).offset(30);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - kRealValue(30), kRealValue(40)));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(kRealValue(21));
        make.centerY.equalTo(self.topView);
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightArrowButton.mas_left).offset(-kRealValue(14));
        make.centerY.equalTo(self.topView);
        make.height.equalTo(@kRealValue(14));
    }];
    
    [self.rightArrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topView).offset(-kRealValue(25));
        make.centerY.equalTo(self.topView);
        make.size.mas_equalTo(CGSizeMake(kRealValue(9), kRealValue(16)));
    }];
    
    [self.keyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView).offset(kRealValue(21));
        make.top.equalTo(self.bottomView).offset(kRealValue(17));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.manageTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.keyLabel.mas_right).offset(kRealValue(10));
        make.right.equalTo(self.sweepButton.mas_left).offset(-kRealValue(14));
        make.centerY.equalTo(self.keyLabel);
        make.height.equalTo(@kRealValue(14));
    }];
    
    [self.sweepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.keyLabel);
        make.right.equalTo(self.bottomView).offset(-kRealValue(25));
        make.size.mas_equalTo(CGSizeMake(kRealValue(22), kRealValue(22)));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.bottomView);
        make.top.equalTo(self.bottomView).offset(kRealValue(45));
        make.height.equalTo(@BORDER_WIDTH_1PX);
    }];
    
    [self.weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView).offset(kRealValue(21));
        make.top.equalTo(self.lineView.mas_bottom).offset(kRealValue(15));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.subtractButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.countLabel.mas_left);
        make.centerY.equalTo(self.weightLabel);
        make.size.mas_equalTo(CGSizeMake(kRealValue(24), kRealValue(24)));
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomView).offset(-kRealValue(25));
        make.centerY.equalTo(self.weightLabel);
        make.size.mas_equalTo(CGSizeMake(kRealValue(24), kRealValue(24)));
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.addButton.mas_left);
        make.centerY.equalTo(self.weightLabel);
        make.size.mas_equalTo(CGSizeMake(kRealValue(24), kRealValue(24)));
    }];
}

#pragma mark - **************** Event Response
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

- (void)sweepButtonClicked {
    
}

- (void)bottomButtonClicked {
    
}

#pragma mark - **************** Setter Getter
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
        _topView.layer.cornerRadius = kRealValue(8);
        [self.view addSubview:_topView];
    }
    return _topView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor qs_colorWhiteFFFFFF];
        _bottomView.layer.cornerRadius = kRealValue(8);
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
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

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = QSLocalizedString(@"qs_add_address_item_name_title");
        _titleLabel.textColor = [UIColor qs_colorBlack333333];
        _titleLabel.font = [UIFont qs_fontOfSize16];
        [self.topView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = QSLocalizedString(@"qs_manage_createGroup_leaf_node");
        _nameLabel.textColor = [UIColor qs_colorGray686868];
        _nameLabel.font = [UIFont qs_fontOfSize14];
        [self.topView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UIButton *)rightArrowButton {
    if (!_rightArrowButton) {
        _rightArrowButton = [[UIButton alloc] init];
        [_rightArrowButton setImage:[UIImage imageNamed:@"icon_erweima_enter"] forState:UIControlStateNormal];
        [self.topView addSubview:_rightArrowButton];
    }
    return _rightArrowButton;
}

- (UILabel *)keyLabel {
    if (!_keyLabel) {
        _keyLabel = [[UILabel alloc] init];
        _keyLabel.text = @"Key";
        _keyLabel.textColor = [UIColor qs_colorBlack333333];
        _keyLabel.font = [UIFont qs_fontOfSize16];
        [self.bottomView addSubview:_keyLabel];
    }
    return _keyLabel;
}

- (UITextField *)manageTextField {
    if (!_manageTextField) {
        _manageTextField = [[UITextField alloc] init];
        _manageTextField.placeholder = QSLocalizedString(@"qs_manage_createGroup_key_placeholder");
        _manageTextField.textColor = [UIColor qs_colorBlack333333];
        _manageTextField.font = [UIFont qs_fontOfSize14];
        [_manageTextField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
        [_manageTextField setValue:[UIFont qs_fontOfSize14] forKeyPath:@"_placeholderLabel.font"];
        _manageTextField.textAlignment = NSTextAlignmentRight;
        [self.bottomView addSubview:_manageTextField];
    }
    return _manageTextField;
}

- (UIButton *)sweepButton {
    if (!_sweepButton) {
        _sweepButton = [[UIButton alloc] init];
        [_sweepButton setImage:[UIImage imageNamed:@"icon_xinjianjiedian_sweep"] forState:UIControlStateNormal];
        [_sweepButton addTarget:self action:@selector(sweepButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:_sweepButton];
    }
    return _sweepButton;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor qs_colorGrayDDDDDD];
        [self.bottomView addSubview:_lineView];
    }
    return _lineView;
}

- (UILabel *)weightLabel {
    if (!_weightLabel) {
        _weightLabel = [[UILabel alloc] init];
        _weightLabel.text = QSLocalizedString(@"qs_manage_createGroup_weight");
        _weightLabel.textColor = [UIColor qs_colorBlack333333];
        _weightLabel.font = [UIFont qs_fontOfSize16];
        [self.bottomView addSubview:_weightLabel];
    }
    return _weightLabel;
}

- (UIButton *)subtractButton {
    if (!_subtractButton) {
        _subtractButton = [[UIButton alloc] init];
        [_subtractButton setImage:[UIImage imageNamed:@"icon_wodeyu_minus"] forState:UIControlStateNormal];
        [_subtractButton addTarget:self action:@selector(subtractAction) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:_subtractButton];
    }
    return _subtractButton;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [[UIButton alloc] init];
        [_addButton setImage:[UIImage imageNamed:@"icon_wodeyu_plus"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:_addButton];
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
        [self.bottomView addSubview:_countLabel];
    }
    return _countLabel;
}

@end

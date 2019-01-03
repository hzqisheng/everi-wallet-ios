//
//  QSIssuePermissionsIssueView.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/12.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSIssuePermissionsIssueView.h"

@implementation QSIssuePermissionsIssueView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kRealValue(15));
        make.top.equalTo(self).offset(kRealValue(16));
        make.size.mas_equalTo(CGSizeMake(kRealValue(2), kRealValue(14)));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.blueView.mas_right).offset(kRealValue(9));
        make.centerY.equalTo(self.blueView);
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.top.equalTo(self).offset(kRealValue(45));
        make.height.equalTo(@BORDER_WIDTH_1PX);
    }];
    
    [self.onlyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kRealValue(26));
        make.top.equalTo(self.lineView1.mas_bottom).offset(kRealValue(16));
        make.size.mas_equalTo(CGSizeMake(kRealValue(16), kRealValue(16)));
    }];
    
    [self.onlyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.onlyButton.mas_right).offset(kRealValue(12));
        make.centerY.equalTo(self.onlyButton);
        make.height.equalTo(@kRealValue(14));
    }];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.top.equalTo(self.lineView1.mas_bottom).offset(kRealValue(48));
        make.height.equalTo(@BORDER_WIDTH_1PX);
    }];
    
    [self.manualButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.onlyButton);
        make.top.equalTo(self.lineView2.mas_bottom).offset(kRealValue(16));
        make.size.mas_equalTo(CGSizeMake(kRealValue(16), kRealValue(16)));
    }];
    
    [self.manualLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.manualButton.mas_right).offset(kRealValue(12));
        make.centerY.equalTo(self.manualButton);
        make.height.equalTo(@kRealValue(14));
    }];
    
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-kRealValue(25));
        make.centerY.equalTo(self.manualButton);
        make.size.mas_equalTo(CGSizeMake(kRealValue(30), kRealValue(14)));
    }];
}

#pragma mark - **************** Event Response
- (void)didClickOnlyButton {
    self.onlyButton.selected = !self.onlyButton.selected;
    self.manualButton.selected = NO;
}

- (void)didClickManualButton {
    self.onlyButton.selected = NO;
    self.manualButton.selected = !self.manualButton.selected;
}

- (void)didClickEditButton {
    self.onlyButton.selected = NO;
    self.manualButton.selected = YES;
    if (self.issuePermissionsIssueViewClickEditBlock) {
        self.issuePermissionsIssueViewClickEditBlock();
    }
}

#pragma mark - **************** Setter Getter
- (UIView *)blueView {
    if (!_blueView) {
        _blueView = [[UIView alloc] init];
        _blueView.backgroundColor = [UIColor qs_colorBlue4D7BF3];
        [self addSubview:_blueView];
    }
    return _blueView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = QSLocalizedString(@"qs_btn_home_issue");
        _titleLabel.textColor = [UIColor qs_colorBlack333333];
        _titleLabel.font = [UIFont qs_boldFontOfSize16];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIView *)lineView1 {
    if (!_lineView1) {
        _lineView1 = [[UIView alloc] init];
        _lineView1.backgroundColor = [UIColor qs_colorGrayDDDDDD];
        [self addSubview:_lineView1];
    }
    return _lineView1;
}

- (UIButton *)onlyButton {
    if (!_onlyButton) {
        _onlyButton = [[UIButton alloc] init];
        [_onlyButton setImage:[UIImage imageNamed:@"icon_quanxianshezhi_unselected"] forState:UIControlStateNormal];
        [_onlyButton setImage:[UIImage imageNamed:@"icon_quanxianbianji_selected"] forState:UIControlStateSelected];
        [_onlyButton addTarget:self action:@selector(didClickOnlyButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_onlyButton];
    }
    return _onlyButton;
}

- (UILabel *)onlyLabel {
    if (!_onlyLabel) {
        _onlyLabel = [[UILabel alloc] init];
        _onlyLabel.text = QSLocalizedString(@"qs_issue_issue_permissions_content0");
        _onlyLabel.textColor = [UIColor qs_colorBlack313745];
        _onlyLabel.font = [UIFont qs_fontOfSize14];
        [self addSubview:_onlyLabel];
    }
    return _onlyLabel;
}

- (UIView *)lineView2 {
    if (!_lineView2) {
        _lineView2 = [[UIView alloc] init];
        _lineView2.backgroundColor = [UIColor qs_colorGrayDDDDDD];
        [self addSubview:_lineView2];
    }
    return _lineView2;
}


- (UIButton *)manualButton {
    if (!_manualButton) {
        _manualButton = [[UIButton alloc] init];
        [_manualButton setImage:[UIImage imageNamed:@"icon_quanxianshezhi_unselected"] forState:UIControlStateNormal];
        [_manualButton setImage:[UIImage imageNamed:@"icon_quanxianbianji_selected"] forState:UIControlStateSelected];
        [_manualButton addTarget:self action:@selector(didClickManualButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_manualButton];
    }
    return _manualButton;
}

- (UILabel *)manualLabel {
    if (!_manualLabel) {
        _manualLabel = [[UILabel alloc] init];
        _manualLabel.text = QSLocalizedString(@"qs_issue_issue_permissions_content1");
        _manualLabel.textColor = [UIColor qs_colorBlack313745];
        _manualLabel.font = [UIFont qs_fontOfSize14];
        [self addSubview:_manualLabel];
    }
    return _manualLabel;
}

- (UIButton *)editButton {
    if (!_editButton) {
        _editButton = [[UIButton alloc] init];
        [_editButton setTitle:QSLocalizedString(@"qs_issue_issue_permissions_edit") forState:UIControlStateNormal];
        [_editButton addTarget:self action:@selector(didClickEditButton) forControlEvents:UIControlEventTouchUpInside];
        [_editButton setTitleColor:[UIColor qs_colorBlue4D7BF3] forState:UIControlStateNormal];
        _editButton.titleLabel.font = [UIFont qs_fontOfSize14];
        [self addSubview:_editButton];
    }
    return _editButton;
}

@end

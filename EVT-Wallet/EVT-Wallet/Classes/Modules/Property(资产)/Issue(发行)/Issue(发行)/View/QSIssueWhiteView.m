//
//  QSIssueWhiteView.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/12.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSIssueWhiteView.h"

@implementation QSIssueWhiteView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    [self.circulationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kRealValue(20));
        make.top.equalTo(self).offset(kRealValue(15));
        make.right.equalTo(self).offset(-kRealValue(20));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.circulationGrayTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.circulationLabel);
        make.top.equalTo(self.circulationLabel.mas_bottom).offset(kRealValue(12));
        make.right.equalTo(self).offset(-kRealValue(20));
        make.height.equalTo(@kRealValue(12));
    }];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.top.equalTo(self).offset(kRealValue(70));
        make.height.equalTo(@BORDER_WIDTH_1PX);
    }];
    
    [self.addressTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.circulationLabel);
        make.top.equalTo(self.lineView1.mas_bottom).offset(kRealValue(15));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.addressTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressTitleLabel);
        make.top.equalTo(self.addressTitleLabel.mas_bottom).offset(kRealValue(15));
        make.right.equalTo(self.sweepButton.mas_left).offset(-kRealValue(10));
        make.height.equalTo(@kRealValue(13));
    }];
    
    [self.addressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressTitleLabel.mas_right).offset(kRealValue(10));
        make.top.equalTo(self.lineView1.mas_bottom).offset(kRealValue(12));
        make.size.mas_equalTo(CGSizeMake(kRealValue(22), kRealValue(22)));
    }];
    
    [self.sweepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-kRealValue(20));
        make.top.equalTo(self.lineView1.mas_bottom).offset(kRealValue(24));
        make.size.mas_equalTo(CGSizeMake(kRealValue(22), kRealValue(22)));
    }];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.top.equalTo(self.lineView1.mas_bottom).offset(kRealValue(70));
        make.height.equalTo(@BORDER_WIDTH_1PX);
    }];
    
    [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressTitleLabel);
        make.top.equalTo(self.lineView2.mas_bottom).offset(kRealValue(15));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.remarkTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.remarkLabel);
        make.top.equalTo(self.remarkLabel.mas_bottom).offset(kRealValue(11));
        make.right.equalTo(self).offset(-kRealValue(20));
        make.height.equalTo(@kRealValue(16));
    }];
}

#pragma mark - **************** Block
- (void)selectAddressAction {
    if (self.issueWhiteViewDidClickChooseAddressButtonBlock) {
        self.issueWhiteViewDidClickChooseAddressButtonBlock();
    }
}

- (void)sweepButtonClicked {
    if (self.issueWhiteViewDidClickSweepButtonBlock) {
        self.issueWhiteViewDidClickSweepButtonBlock();
    }
}

#pragma mark - **************** Setter Getter
- (UILabel *)circulationLabel {
    if (!_circulationLabel) {
        _circulationLabel = [[UILabel alloc] init];
        _circulationLabel.text = QSLocalizedString(@"qs_issue_issue_circulation_title");
        _circulationLabel.textColor = [UIColor qs_colorBlack333333];
        _circulationLabel.font = [UIFont qs_fontOfSize16];
        [self addSubview:_circulationLabel];
    }
    return _circulationLabel;
}

- (UITextField *)circulationGrayTextField {
    if (!_circulationGrayTextField) {
        _circulationGrayTextField = [[UITextField alloc] init];
        _circulationGrayTextField.placeholder = QSLocalizedString(@"qs_issue_issue_circulation_placeholder");
        _circulationGrayTextField.textColor = [UIColor qs_colorBlack333333];
        _circulationGrayTextField.font = [UIFont qs_fontOfSize15];
        [_circulationGrayTextField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
        [_circulationGrayTextField setValue:[UIFont qs_fontOfSize15] forKeyPath:@"_placeholderLabel.font"];
        [self addSubview:_circulationGrayTextField];
    }
    return _circulationGrayTextField;
}

- (UIView *)lineView1 {
    if (!_lineView1) {
        _lineView1 = [[UIView alloc] init];
        _lineView1.backgroundColor = [UIColor qs_colorGrayDDDDDD];
        [self addSubview:_lineView1];
    }
    return _lineView1;
}

- (UILabel *)addressTitleLabel {
    if (!_addressTitleLabel) {
        _addressTitleLabel = [[UILabel alloc] init];
        _addressTitleLabel.text = QSLocalizedString(@"qs_issue_issue_address_title");
        _addressTitleLabel.textColor = [UIColor qs_colorBlack333333];
        _addressTitleLabel.font = [UIFont qs_fontOfSize16];
        [self addSubview:_addressTitleLabel];
    }
    return _addressTitleLabel;
}

- (UITextField *)addressTextField {
    if (!_addressTextField) {
        _addressTextField = [[UITextField alloc] init];
        _addressTextField.text = QSPublicKey;
        _addressTextField.placeholder = QSLocalizedString(@"qs_add_address_item_address_placeholder");
        _addressTextField.textColor = [UIColor qs_colorGray686868];
        _addressTextField.font = [UIFont qs_fontOfSize13];
        [_addressTextField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
        [_addressTextField setValue:[UIFont qs_fontOfSize13] forKeyPath:@"_placeholderLabel.font"];
        [self addSubview:_addressTextField];
    }
    return _addressTextField;
}

- (UIImageView *)addressImageView {
    if (!_addressImageView) {
        _addressImageView = [[UIImageView alloc] init];
        [_addressImageView setImage:[UIImage imageNamed:@"icon_fukuan_dress"]];
        _addressImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectAddressAction)];
        [_addressImageView addGestureRecognizer:tap];
        [self addSubview:_addressImageView];
    }
    return _addressImageView;
}

- (UIButton *)sweepButton {
    if (!_sweepButton) {
        _sweepButton = [[UIButton alloc] init];
        [_sweepButton setImage:[UIImage imageNamed:@"icon_fukuan_sweep"] forState:UIControlStateNormal];
        [_sweepButton addTarget:self action:@selector(sweepButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sweepButton];
    }
    return _sweepButton;
}

- (UIView *)lineView2 {
    if (!_lineView2) {
        _lineView2 = [[UIView alloc] init];
        _lineView2.backgroundColor = [UIColor qs_colorGrayDDDDDD];
        [self addSubview:_lineView2];
    }
    return _lineView2;
}

- (UILabel *)remarkLabel {
    if (!_remarkLabel) {
        _remarkLabel = [[UILabel alloc] init];
        _remarkLabel.text = QSLocalizedString(@"qs_issue_issue_remarks_title");
        _remarkLabel.textColor = [UIColor qs_colorBlack333333];
        _remarkLabel.font = [UIFont qs_fontOfSize16];
        [self addSubview:_remarkLabel];
    }
    return _remarkLabel;
}

- (UITextField *)remarkTextField {
    if (!_remarkTextField) {
        _remarkTextField = [[UITextField alloc] init];
        _remarkTextField.placeholder = QSLocalizedString(@"qs_issue_issue_remarks_placeholder");
        _remarkTextField.textColor = [UIColor qs_colorBlack333333];
        _remarkTextField.font = [UIFont qs_fontOfSize15];
        [_remarkTextField setValue:[UIColor qs_colorGrayBBBBBB] forKeyPath:@"_placeholderLabel.textColor"];
        [_remarkTextField setValue:[UIFont qs_fontOfSize15] forKeyPath:@"_placeholderLabel.font"];
        [self addSubview:_remarkTextField];
    }
    return _remarkTextField;
}

@end

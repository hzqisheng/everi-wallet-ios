//
//  QSIssueMoreSettingTopView.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/12.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSIssueMoreSettingTopView.h"

@implementation QSIssueMoreSettingTopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    [self.EVTLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kRealValue(20));
        make.top.equalTo(self).offset(kRealValue(15));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.EVTLabel);
        make.top.equalTo(self.EVTLabel.mas_bottom).offset(kRealValue(12));
        make.height.equalTo(@kRealValue(15));
    }];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.top.equalTo(self).offset(kRealValue(70));
        make.height.equalTo(@BORDER_WIDTH_1PX);
    }];
    
    [self.issueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.EVTLabel);
        make.top.equalTo(self.lineView1.mas_bottom).offset(kRealValue(17));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.issueThresholdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.issueLabel);
        make.top.equalTo(self.issueLabel.mas_bottom).offset(kRealValue(11));
        make.height.equalTo(@kRealValue(15));
    }];
    
    [self.issueLetterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.issueLabel);
        make.top.equalTo(self.issueThresholdLabel.mas_bottom).offset(kRealValue(11));
        make.right.equalTo(self).offset(-kRealValue(20));
        make.height.equalTo(@kRealValue(15));
    }];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.top.equalTo(self.lineView1.mas_bottom).offset(kRealValue(98));
        make.height.equalTo(@BORDER_WIDTH_1PX);
    }];
    
    [self.managementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.EVTLabel);
        make.top.equalTo(self.lineView2.mas_bottom).offset(kRealValue(15));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.managementThresholdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.managementLabel);
        make.top.equalTo(self.managementLabel.mas_bottom).offset(kRealValue(11));
        make.height.equalTo(@kRealValue(15));
    }];
}

#pragma mark - **************** Setter Getter
- (UILabel *)EVTLabel {
    if (!_EVTLabel) {
        _EVTLabel = [[UILabel alloc] init];
        _EVTLabel.text = @"EVT(#232423423)";
        _EVTLabel.textColor = [UIColor qs_colorBlack333333];
        _EVTLabel.font = [UIFont qs_fontOfSize16];
        [self addSubview:_EVTLabel];
    }
    return _EVTLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"2018-11-18T03";
        _timeLabel.textColor = [UIColor qs_colorGrayBBBBBB];
        _timeLabel.font = [UIFont qs_fontOfSize15];
        [self addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UIView *)lineView1 {
    if (!_lineView1) {
        _lineView1 = [[UIView alloc] init];
        _lineView1.backgroundColor = [UIColor qs_colorGrayDDDDDD];
        [self addSubview:_lineView1];
    }
    return _lineView1;
}

- (UILabel *)issueLabel {
    if (!_issueLabel) {
        _issueLabel = [[UILabel alloc] init];
        _issueLabel.text = QSLocalizedString(@"qs_btn_home_issue");
        _issueLabel.textColor = [UIColor qs_colorBlack333333];
        _issueLabel.font = [UIFont qs_fontOfSize16];
        [self addSubview:_issueLabel];
    }
    return _issueLabel;
}

- (UILabel *)issueThresholdLabel {
    if (!_issueThresholdLabel) {
        _issueThresholdLabel = [[UILabel alloc] init];
        _issueThresholdLabel.text = @"阙值：0";
        _issueThresholdLabel.textColor = [UIColor qs_colorGrayBBBBBB];
        _issueThresholdLabel.font = [UIFont qs_fontOfSize15];
        [self addSubview:_issueThresholdLabel];
    }
    return _issueThresholdLabel;
}

- (UILabel *)issueLetterLabel {
    if (!_issueLetterLabel) {
        _issueLetterLabel = [[UILabel alloc] init];
        _issueLetterLabel.text = @"[A] Esdsdfgalkj3234aldsfjkaldasdfaljdf2dlj";
        _issueLetterLabel.textColor = [UIColor qs_colorGrayBBBBBB];
        _issueLetterLabel.font = [UIFont qs_fontOfSize15];
        [self addSubview:_issueLetterLabel];
    }
    return _issueLetterLabel;
}

- (UIView *)lineView2 {
    if (!_lineView2) {
        _lineView2 = [[UIView alloc] init];
        _lineView2.backgroundColor = [UIColor qs_colorGrayDDDDDD];
        [self addSubview:_lineView2];
    }
    return _lineView2;
}

- (UILabel *)managementLabel {
    if (!_managementLabel) {
        _managementLabel = [[UILabel alloc] init];
        _managementLabel.text = QSLocalizedString(@"qs_issue_issue_moreSetting_manage");
        _managementLabel.textColor = [UIColor qs_colorBlack333333];
        _managementLabel.font = [UIFont qs_fontOfSize16];
        [self addSubview:_managementLabel];
    }
    return _managementLabel;
}

- (UILabel *)managementThresholdLabel {
    if (!_managementThresholdLabel) {
        _managementThresholdLabel = [[UILabel alloc] init];
        _managementThresholdLabel.text = @"阙值：0";
        _managementThresholdLabel.textColor = [UIColor qs_colorGrayBBBBBB];
        _managementThresholdLabel.font = [UIFont qs_fontOfSize15];
        [self addSubview:_managementThresholdLabel];
    }
    return _managementThresholdLabel;
}

@end

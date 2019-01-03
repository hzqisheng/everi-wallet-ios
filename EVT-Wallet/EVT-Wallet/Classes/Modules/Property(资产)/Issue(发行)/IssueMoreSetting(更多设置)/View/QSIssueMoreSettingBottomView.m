//
//  QSIssueMoreSettingBottomView.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/12.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSIssueMoreSettingBottomView.h"

@implementation QSIssueMoreSettingBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    [self.metadataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kRealValue(20));
        make.top.equalTo(self).offset(kRealValue(15));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kRealValue(20));
        make.top.equalTo(self.metadataLabel.mas_bottom).offset(kRealValue(12));
        make.right.equalTo(self).offset(-kRealValue(20));
        make.height.equalTo(@kRealValue(62));
    }];
}

#pragma mark - **************** Block
- (void)addMetadataAction {
    if (self.issueMoreSettingBottomViewAddMetadataBlock) {
        self.issueMoreSettingBottomViewAddMetadataBlock();
    }
}

#pragma mark - **************** Setter Getter
- (UILabel *)metadataLabel {
    if (!_metadataLabel) {
        _metadataLabel = [[UILabel alloc] init];
        _metadataLabel.text = QSLocalizedString(@"qs_issue_issue_moreSetting_metadata");
        _metadataLabel.textColor = [UIColor qs_colorBlack333333];
        _metadataLabel.font = [UIFont qs_fontOfSize16];
        [self addSubview:_metadataLabel];
    }
    return _metadataLabel;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [[UIButton alloc] init];
        [_addButton setImage:[UIImage imageNamed:@"icon_faxing_increase"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addMetadataAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_addButton];
    }
    return _addButton;
}

@end

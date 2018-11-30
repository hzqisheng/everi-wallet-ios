//
//  QSMyWalletSectionHeaderView.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/28.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSMyWalletSectionHeaderView.h"

@implementation QSMyWalletSectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self p_setupSubViews];
    }
    return self;
}

- (void)p_setupSubViews {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.addButton];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@kRealValue(19));
        make.left.equalTo(@kRealValue(17));
        make.right.equalTo(self.addButton.mas_left).offset(-kRealValue(12));
        make.height.equalTo(@([UIFont qs_fontOfSize15].lineHeight));
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.right.equalTo(self.contentView).offset(-kRealValue(14));
        make.width.and.height.equalTo(@kRealValue(22));
    }];
}

#pragma mark - **************** Event Response
- (void)addButtonClicked {
    if (self.walletSectionHeaderClickedBlock) {
        self.walletSectionHeaderClickedBlock(self.section);
    }
}

#pragma mark - **************** Setter Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithName:@"title" font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithImage:@"icon_qianbao_plus" taget:self action:@selector(addButtonClicked)];
    }
    return _addButton;
}

- (void)setSection:(NSInteger)section {
    _section = section;
}

@end

//
//  QSManageSelectAddressCell.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/14.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSManageSelectAddressCell.h"
#import "QSManageSelectAddressItem.h"

@implementation QSManageSelectAddressCell

- (void)configureSubViews {
    self.contentView.backgroundColor = [UIColor clearColor];
    [self loadUI];
}

- (void)loadUI {
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kRealValue(16));
        make.top.equalTo(self.contentView).offset(kRealValue(24));
        make.size.mas_equalTo(CGSizeMake(kRealValue(16), kRealValue(16)));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftButton.mas_right).offset(kRealValue(19));
        make.top.equalTo(self.contentView).offset(kRealValue(16));
        make.right.equalTo(self.contentView).offset(-kRealValue(20));
        make.height.equalTo(@kRealValue(15));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRealValue(8));
        make.right.equalTo(self.titleLabel);
        make.height.equalTo(@kRealValue(13));
    }];
}

- (void)configureCellWithItem:(QSBaseCellItem *)item {
    self.item = item;
    QSManageSelectAddressItem *groupItem = (QSManageSelectAddressItem *)item;
    self.titleLabel.text = groupItem.title;
    self.nameLabel.text = groupItem.content;
    self.leftButton.selected = groupItem.isSelected;
}

#pragma mark - **************** Setter Getter
- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] init];
        [_leftButton setImage:[UIImage imageNamed:@"icon_quanxianshezhi_unselected"] forState:UIControlStateNormal];
        [_leftButton setImage:[UIImage imageNamed:@"icon_quanxianbianji_selected"] forState:UIControlStateSelected];
        [self.contentView addSubview:_leftButton];
    }
    return _leftButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor qs_colorBlack313745];
        _titleLabel.font = [UIFont qs_fontOfSize15];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor qs_colorGray686868];
        _nameLabel.font = [UIFont qs_fontOfSize13];
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

@end

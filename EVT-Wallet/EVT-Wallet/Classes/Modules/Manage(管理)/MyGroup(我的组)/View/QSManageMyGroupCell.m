//
//  QSManageMyGroupCell.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/13.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSManageMyGroupCell.h"
#import "QSManageMyGroupItem.h"

@implementation QSManageMyGroupCell

- (void)configureSubViews {
    self.contentView.backgroundColor = [UIColor clearColor];
    [self loadUI];
}

- (void)loadUI {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kRealValue(20));
        make.top.equalTo(self.contentView).offset(kRealValue(18));
        make.right.equalTo(self.contentView).offset(-kRealValue(20));
        make.height.equalTo(@kRealValue(16));
    }];
}

- (void)configureCellWithItem:(QSBaseCellItem *)item {
    self.item = item;
    QSManageMyGroupItem *groupItem = (QSManageMyGroupItem *)item;
    self.titleLabel.text = groupItem.title;
    
}

#pragma mark - **************** Setter Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont qs_fontOfSize16];
        _titleLabel.textColor = [UIColor qs_colorBlack333333];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end

//
//  QSTransactionTitleCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/7.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSTransactionRecordTitleCell.h"

@interface QSTransactionRecordTitleCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation QSTransactionRecordTitleCell

- (void)configureSubViews {
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(kRealValue(25));
        make.right.equalTo(self.contentView).offset(-kRealValue(25));
    }];
}

- (void)configureCellWithItem:(id<QSBaseCellItemDataProtocol>)item {
    self.item = item;
}

#pragma mark - **************** Setter Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithName:QSLocalizedString(@"qs_transaction_record_item_record_title") font:[UIFont qs_boldFontOfSize16] textColor:[UIColor qs_colorBlack313745] textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

@end

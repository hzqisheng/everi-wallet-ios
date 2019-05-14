//
//  QSMyPassDetailNameCell.m
//  EVT-Wallet
//
//  Created by SJ on 2019/5/13.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSMyPassDetailNameCell.h"
#import "QSMyPassDetailNameItem.h"

@interface QSMyPassDetailNameCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation QSMyPassDetailNameCell

- (void)configureSubViews {    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kRealValue(15));
        make.left.equalTo(self.contentView).offset(kRealValue(15));
        make.right.equalTo(self.contentView).offset(-kRealValue(15));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(kRealValue(11));
        make.left.and.right.equalTo(self.nameLabel);
        make.bottom.equalTo(self.contentView).offset(-kRealValue(15));
    }];
}

- (void)configureCellWithItem:(id<QSBaseCellItemDataProtocol>)item {
    self.item = item;
    QSMyPassDetailNameItem *nameItem = (QSMyPassDetailNameItem *)self.item;
    
    self.nameLabel.text = nameItem.name;
    self.timeLabel.text = [nameItem.issue_time transformServerTimeToLocalTime];
}

#pragma mark - ***************** Setter Getter
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithName:@"name" font:[UIFont qs_fontOfSize16] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithName:@"time" font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentLeft];
    }
    return _timeLabel;
}

@end

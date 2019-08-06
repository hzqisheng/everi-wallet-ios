//
//  QSEveriPassTransferConfirmCell.m
//  EVT-Wallet
//
//  Created by SJ on 2019/8/6.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSEveriPassTransferConfirmCell.h"
#import "QSEveriPassTransferConfirmItem.h"

@interface QSEveriPassTransferConfirmCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation QSEveriPassTransferConfirmCell

- (void)configureSubViews {
    _titleLabel = [UILabel labelWithName:nil font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_titleLabel];
    
    _contentLabel = [UILabel labelWithName:nil font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
    [_contentLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kRealValue(15));
        make.left.equalTo(self.contentView).offset(kRealValue(15));
        make.right.equalTo(self.contentView).offset(-kRealValue(15));
        make.height.equalTo(@([UIFont qs_fontOfSize14].lineHeight));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRealValue(10));
        make.left.equalTo(self.contentView).offset(kRealValue(15));
        make.right.equalTo(self.contentView).offset(-kRealValue(15));
        make.bottom.equalTo(self.contentView).offset(-kRealValue(15));
    }];
}

- (void)configureCellWithItem:(id<QSBaseCellItemDataProtocol>)item {
    self.item = item;
    
    QSEveriPassTransferConfirmItem *confirmItem = (QSEveriPassTransferConfirmItem *)item;
    
    _titleLabel.text = confirmItem.title;
    
    _contentLabel.text = confirmItem.content;
}

@end

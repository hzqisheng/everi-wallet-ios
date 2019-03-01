//
//  QSWalletDetailCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/4.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSWalletDetailCell.h"
#import "QSWalletContentItem.h"

@interface QSWalletDetailCell ()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation QSWalletDetailCell

- (void)configureCellWithItem:(QSBaseCellItem *)item {
    [super configureCellWithItem:item];
    
    self.leftTitleLabel.y = kRealValue(15);
    
    QSWalletContentItem *contentItem = (QSWalletContentItem *)item;
    
    [self.contentView addSubview:self.contentLabel];
    self.contentLabel.frame = CGRectMake(self.leftTitleLabel.x, self.leftTitleLabel.maxY + kRealValue(7), kRealValue(273), kRealValue(35));
    self.contentLabel.text = contentItem.content;
}

#pragma mark - **************** Setter Getter
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithName:@"" font:[UIFont qs_fontOfSize13] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentLeft];
        _contentLabel.numberOfLines = 2;
    }
    return _contentLabel;
}

@end

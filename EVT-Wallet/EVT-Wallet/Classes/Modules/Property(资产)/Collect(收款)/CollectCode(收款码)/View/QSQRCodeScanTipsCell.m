//
//  QSQRCodeScanTipsCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/5.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSQRCodeScanTipsCell.h"

@interface QSQRCodeScanTipsCell ()

@property (nonatomic, strong) UILabel *tipsLabel;

@end

@implementation QSQRCodeScanTipsCell

- (void)configureSubViews {
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.tipsLabel];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - **************** Setter Getter
- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [UILabel labelWithName:QSLocalizedString(@"qs_collect_item_tips_title") font:[UIFont qs_fontOfSize16] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentCenter];
    }
    return _tipsLabel;
}

@end

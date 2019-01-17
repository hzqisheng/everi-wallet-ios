//
//  QSCollectTipsCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/1/17.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSCollectTipsCell.h"

@interface QSCollectTipsCell ()

@property (nonatomic, strong) UILabel *tipsLabel;

@end

@implementation QSCollectTipsCell

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

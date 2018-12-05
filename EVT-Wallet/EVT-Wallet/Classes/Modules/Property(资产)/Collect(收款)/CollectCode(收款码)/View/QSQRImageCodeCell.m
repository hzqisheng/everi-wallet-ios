//
//  QSQRImageCodeCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/5.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSQRImageCodeCell.h"
#import "QSQRCodeScanItem.h"

@interface QSQRImageCodeCell ()

@property (nonatomic, strong) UIImageView *qrCodeImageView;
@property (nonatomic, strong) UIButton *pastButton;

@end

@implementation QSQRImageCodeCell

- (void)configureSubViews {
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.qrCodeImageView];
    [self.contentView addSubview:self.pastButton];
    
    [self.qrCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kRealValue(28));
        make.centerX.equalTo(self.contentView);
        make.width.and.height.equalTo(@kRealValue(225));
    }];
    
    [self.pastButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.qrCodeImageView.mas_bottom).offset(kRealValue(7));
        make.centerX.equalTo(self.contentView);
        make.height.mas_equalTo(@kRealValue(20));
        make.width.lessThanOrEqualTo(@kRealValue(250));
    }];
}

- (void)configureCellWithItem:(QSBaseCellItem *)item {
    self.item = item;
}

#pragma mark - **************** Event Response
- (void)pastButtonClicked {
    QSQRCodeScanItem *scanItem = (QSQRCodeScanItem *)self.item;
    if (scanItem.address.length) {
        UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:kWechatAddress];
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_collect_btn_copy_success_title")];
    }
}

#pragma mark - **************** Setter Getter
- (UIImageView *)qrCodeImageView {
    if (!_qrCodeImageView) {
        _qrCodeImageView = [[UIImageView alloc] init];
        _qrCodeImageView.backgroundColor = [UIColor grayColor];
        _qrCodeImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pastButtonClicked)];
        [_qrCodeImageView addGestureRecognizer:tap];
    }
    return _qrCodeImageView;
}

- (UIButton *)pastButton {
    if (!_pastButton) {
        _pastButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_collect_btn_copy_address_title") titleColor:[UIColor qs_colorGrayBBBBBB] font:[UIFont qs_fontOfSize14] taget:self action:@selector(pastButtonClicked)];
    }
    return _pastButton;
}


@end

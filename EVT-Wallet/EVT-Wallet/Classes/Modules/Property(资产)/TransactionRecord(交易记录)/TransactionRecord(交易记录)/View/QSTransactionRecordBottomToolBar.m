//
//  QSTransactionRecordBottomToolBar.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/7.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSTransactionRecordBottomToolBar.h"

@implementation QSTransactionRecordBottomToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor qs_colorWhiteF5F7FB];
        [self p_setupSubViews];
    }
    return self;
}

- (void)p_setupSubViews {
    //transfer
    UIButton *transferButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_transaction_record_tansfer_btn_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize15] taget:self action:@selector(buttonClicked:)];
    transferButton.layer.cornerRadius = 4;
    transferButton.backgroundColor = [UIColor qs_colorBlack313745];
    [self addSubview:transferButton];
    transferButton.tag = 0;
    [transferButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kRealValue(15));
        make.left.equalTo(self).offset(kRealValue(15));
        make.width.equalTo(@kRealValue(109));
        make.height.equalTo(@kRealValue(40));
    }];
    
    //transfer
    UIButton *batchTransferButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_transaction_record_batch_tansfer_btn_title") titleColor:[UIColor qs_colorYellowE4B84F] font:[UIFont qs_fontOfSize15] taget:self action:@selector(buttonClicked:)];
    batchTransferButton.layer.cornerRadius = 4;
    batchTransferButton.backgroundColor = [UIColor qs_colorBlack313745];
    [self addSubview:batchTransferButton];
    batchTransferButton.tag = 1;
    [batchTransferButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(transferButton);
        make.centerX.equalTo(self);
        make.width.and.height.equalTo(transferButton);
    }];
    
    //transfer
    UIButton *collectButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_transaction_record_collect_btn_title") titleColor:[UIColor whiteColor] font:[UIFont qs_fontOfSize15] taget:self action:@selector(buttonClicked:)];
    collectButton.layer.cornerRadius = 4;
    collectButton.backgroundColor = [UIColor qs_colorBlue4D7BF3];
    [self addSubview:collectButton];
    collectButton.tag = 2;
    [collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(batchTransferButton);
        make.left.equalTo(batchTransferButton.mas_right).offset(kRealValue(9));
        make.width.and.height.equalTo(batchTransferButton);
    }];
}

+ (CGFloat)toolBarHeight {
    return kDevice_Is_iPhoneX ? kRealValue(55) + kiPhoneXSafeAreaBottomMagin : kRealValue(70);
}

#pragma mark - **************** Setter Getter
- (void)buttonClicked:(UIButton *)button {
    if (self.toolBarClickedBlock) {
        self.toolBarClickedBlock(button.tag);
    }
}

@end

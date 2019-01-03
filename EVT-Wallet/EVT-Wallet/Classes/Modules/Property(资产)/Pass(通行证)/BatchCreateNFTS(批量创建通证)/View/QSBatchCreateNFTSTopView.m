//
//  QSBatchCreateNFTSTopView.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/13.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBatchCreateNFTSTopView.h"

@interface QSBatchCreateNFTSTopView ()<YYTextViewDelegate>

@end

@implementation QSBatchCreateNFTSTopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kRealValue(21));
        make.right.equalTo(self).offset(-kRealValue(21));
        make.top.equalTo(self).offset(kRealValue(25));
        make.height.equalTo(@kRealValue(88));
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-kRealValue(20));
        make.top.equalTo(self.textView.mas_bottom).offset(kRealValue(10));
        make.height.equalTo(@kRealValue(13));
    }];
}


- (void)textViewDidChange:(YYTextView *)textView {
    NSArray *nameArr = [textView.text componentsSeparatedByString:@"\n"];
    self.countLabel.text = [NSString stringWithFormat:@"%@:%ld",QSLocalizedString(@"qs_pass_createNFTS_batch_count"),nameArr.count];
}


#pragma mark - **************** Setter Getter
- (YYTextView *)textView {
    if (!_textView) {
        _textView = [[YYTextView alloc] init];
        _textView.textColor = [UIColor qs_colorBlack333333];
        _textView.font = [UIFont qs_fontOfSize14];
        _textView.placeholderText = QSLocalizedString(@"qs_pass_createNFTS_batch_topView_placeholder");
        _textView.placeholderFont = [UIFont qs_fontOfSize14];
        _textView.placeholderTextColor = [UIColor qs_colorGrayBBBBBB];
        _textView.delegate = self;
        [self addSubview:_textView];
    }
    return _textView;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.text = [NSString stringWithFormat:@"%@:0",QSLocalizedString(@"qs_pass_createNFTS_batch_count")];
        _countLabel.textColor = [UIColor qs_colorGray686868];
        _countLabel.font = [UIFont qs_fontOfSize13];
        _countLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_countLabel];
    }
    return _countLabel;
}

@end

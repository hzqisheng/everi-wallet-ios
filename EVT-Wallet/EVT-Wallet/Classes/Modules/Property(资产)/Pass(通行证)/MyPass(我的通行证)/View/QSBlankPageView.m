//
//  QSBlankPageView.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/12.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBlankPageView.h"

@implementation QSBlankPageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kRealValue(154), kRealValue(154)));
    }];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageView);
        make.top.equalTo(self.imageView.mas_bottom).offset(-kRealValue(7));
        make.height.equalTo(@kRealValue(15));
    }];
}

#pragma mark - **************** Setter Getter
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [_imageView setImage:[UIImage imageNamed:@"icon_wodeyu_nothing"]];
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.text = @"暂无域信息";
        _textLabel.font = [UIFont qs_fontOfSize15];
        _textLabel.textColor = [UIColor qs_colorGrayCCCCCC];
        [self addSubview:_textLabel];
    }
    return _textLabel;
}


@end

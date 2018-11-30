//
//  QSSettingItem.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/27.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSSettingItem.h"

@implementation QSSettingItem

- (instancetype)init {
    if (self = [super init]) {
        _cellIdentifier = @"QSSettingCell";
        _cellType = QSSettingItemTypeDefault;
        _cellHeight = kRealValue(52);
        _cellWidth = kScreenWidth - kRealValue(30);
        
        _leftSubviewMargin = kRealValue(20);
        _leftImageSize = CGSizeMake(kRealValue(22), kRealValue(22));
        _leftTitleFont = [UIFont qs_fontOfSize14];
        _leftTitleColor = [UIColor qs_colorBlack333333];
        _leftImageAndTitleSpace = kRealValue(18);
        
        _arrowImageViewSize = CGSizeMake(kRealValue(22), kRealValue(22));
        _rightSubviewMargin = kRealValue(13);
        _rightTitleColor = [UIColor qs_colorGrayBBBBBB];
        _rightTitleFont = [UIFont qs_fontOfSize14];
        _rightArrowAndTitleSpace = kRealValue(8);
    }
    return self;
}

- (void)setLeftTitle:(NSString *)leftTitle {
    if (_leftTitle != leftTitle) {
        
        _leftTitle = leftTitle;
        _leftTitleLabelSize = [self sizeForTitle:leftTitle withFont:_leftTitleFont];
        
        //very long title 最大为180
        if (_leftTitleLabelSize.width > kRealValue(180)) {
            CGSize size = _leftTitleLabelSize;
            size.width = kRealValue(180);
            _leftTitleLabelSize = size;
        }
    }
}

- (void)setLeftTitleFont:(UIFont *)leftTitleFont {
    if (_leftTitleFont != leftTitleFont) {
        
        if (![self font1:_leftTitleFont hasSameFontSizeOfFont2:leftTitleFont]) {
            //如果新的宽度大于原来的宽度，需要重新设置，否则不需要
            _leftTitleFont = leftTitleFont;
            CGSize size = [self sizeForTitle:self.leftTitle withFont:leftTitleFont];
            if (size.width > self.leftTitleLabelSize.width) {
                _leftTitleLabelSize = size;
            }
        }
    }
}

- (void)setRightTitle:(NSString *)rightTitle {
    if (_rightTitle != rightTitle) {
        
        _rightTitle = rightTitle;
        _rightTitleLabelSize = [self sizeForTitle:rightTitle withFont:_rightTitleFont];
        
        //very long title 最大为100
        CGFloat maxW;
        if (self.cellType == QSSettingItemTypeLeftRightTitle) {
            maxW = self.cellWidth - self.leftSubviewMargin - self.leftTitleLabelSize.width - self.rightSubviewMargin - self.arrowImageViewSize.width - self.rightArrowAndTitleSpace - 5;
        } else {
            maxW = kRealValue(100);
        }
        if (_rightTitleLabelSize.width > maxW) {
            CGSize size = _rightTitleLabelSize;
            size.width = maxW;
            _rightTitleLabelSize = size;
        }
    }
}

- (void)setRightTitleFont:(UIFont *)rightTitleFont {
    if (_rightTitleFont != rightTitleFont) {
        
        if (![self font1:_rightTitleFont hasSameFontSizeOfFont2:rightTitleFont]) {
            //如果新的宽度大于原来的宽度，需要重新设置，否则不需要
            _rightTitleFont = rightTitleFont;
            CGSize size = [self sizeForTitle:self.rightTitle withFont:rightTitleFont];
            if (size.width > self.leftTitleLabelSize.width) {
                _rightTitleLabelSize = size;
            }
        }
    }
}

- (CGSize)sizeForTitle:(NSString *)title withFont:(UIFont *)font {
    CGRect titleRect = [title boundingRectWithSize:CGSizeMake(FLT_MAX, FLT_MAX)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName : font}
                                           context:nil];
    
    return CGSizeMake(titleRect.size.width,
                      titleRect.size.height);
}

//判断字体大小是否一致
- (BOOL)font1:(UIFont *)font1 hasSameFontSizeOfFont2:(UIFont *)font2 {
    BOOL res = NO;
    UIFontDescriptor *font1Des = font1.fontDescriptor;
    NSNumber *font1Number = [font1Des objectForKey:@"NSFontSizeAttribute"];
    
    UIFontDescriptor *font2Des = font2.fontDescriptor;
    NSNumber *font2Number = [font2Des objectForKey:@"NSFontSizeAttribute"];
    
    if ([font1Number integerValue] == [font2Number integerValue]) {
        res = YES;
    }
    
    return res;
}

@end

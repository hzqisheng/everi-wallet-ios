//
//  QSHelpCenterItem.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/29.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSHelpCenterOverViewItem.h"

@implementation QSHelpCenterOverViewItem

- (instancetype)init {
    if (self = [super init]) {
        _functionOverViewFont = [UIFont qs_fontOfSize14];
        _functionOverViewTextColor = [UIColor qs_colorGray686868];
        _functionOverViewTopMargin = kRealValue(15);
        _leftTitleTopMargin = kRealValue(21);
        _cellNoExpandHeight = self.cellHeight;
    }
    return self;
}

- (void)setFunctionOverView:(NSString *)functionOverView {
    _functionOverView = functionOverView;
    
    //calculate size
    _functionOverViewSize = [self sizeForTitle:functionOverView withFont:_functionOverViewFont width:self.cellWidth - kRealValue(66)];
    
    //update cell height
    self.cellExpandHeight = self.cellHeight + _functionOverViewSize.height + _functionOverViewTopMargin * 2;
}

- (CGSize)sizeForTitle:(NSString *)title withFont:(UIFont *)font width:(CGFloat)width {
    CGRect titleRect = [title boundingRectWithSize:CGSizeMake(width, FLT_MAX)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName : font}
                                           context:nil];
    
    return CGSizeMake(titleRect.size.width,
                      titleRect.size.height);
}



@end

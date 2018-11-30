//
//  QSAddAddressItem.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/28.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSAddAddressItem.h"

@implementation QSAddAddressItem

- (instancetype)init {
    if (self = [super init]) {
        _typeButtonLeftMargin = kRealValue(83);
        _typeButtonSpace = kRealValue(8);
        _typeButtonSize = CGSizeMake(kRealValue(50), kRealValue(25));
        
        _textFieldLeftMargin = kRealValue(83);
        _textFieldRightMargin = kRealValue(26);
        
        _scanButtonSize = CGSizeMake(kRealValue(22), kRealValue(22));
        self.rightSubviewMargin = kRealValue(25);
    }
    return self;
}

@end
